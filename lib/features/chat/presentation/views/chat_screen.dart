import 'package:activ/constants/asset_paths.dart';
import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/chat/presentation/cubit/cubit.dart';
import 'package:activ/features/chat/presentation/cubit/state.dart';
import 'package:activ/features/chat/presentation/widgets/chat_tile.dart';
import 'package:activ/features/home/presentation/cubit/cubit.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:activ/utils/widgets/core_widgets/app_bar.dart';
import 'package:activ/utils/widgets/core_widgets/icon_button.dart';
import 'package:activ/utils/widgets/core_widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:activ/constants/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'package:activ/utils/helpers/logger_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    _connectStreamUser();
    context.read<ChatCubit>().getChats();
  }

  Future<void> _connectStreamUser() async {
    try {
      final user = context.read<HomeCubit>().state.user.data;
      if (user != null) {
        AppLogger.info(
          'Connecting user with ID: ${user.id}, Stream ID: ${user.getstreamUserId}',
        );
        await StreamChat.of(context).client.disconnectUser();

        await StreamChat.of(context).client.connectUser(
              user.toStreamChatUser(),
              context.read<ChatCubit>().state.streamChatAuth.data?.token ?? '',
            );
      } else {
        AppLogger.error(
          'No user data available - cannot connect to Stream Chat',
        );
        throw Exception('User data not available');
      }
    } catch (e) {
      AppLogger.error('Error connecting Stream user: $e');
      rethrow; // Don't fallback to anonymous - this causes permission issues
    }
  }

  // Create controller dynamically based on backend chat IDs
  StreamChannelListController _createController(List<String> chatIds) {
    // Convert backend IDs to proper Stream Chat CIDs
    final cids = chatIds.map((id) => id).toList();

    // Get current user ID for member filter
    final currentUserId = context.read<HomeCubit>().state.user.data?.id;

    AppLogger.info('Creating controller with CIDs: $cids');
    AppLogger.info('Current user ID: $currentUserId');

    return StreamChannelListController(
      client: StreamChat.of(context).client,
      filter: Filter.and([
        Filter.in_('cid', cids), // Only channels with these CIDs
        Filter.in_(
          'members',
          [currentUserId!],
        ), // Only channels user is a member of
      ]),
      channelStateSort: const [SortOption('last_message_at')],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: activAppBar(
        title: 'Chat',
        context: context,
        backgroundColor: AppColors.primaryColor,
        actionWidget: ActivIconButton(
          backgroundColor: Colors.transparent,
          icon: SvgPicture.asset(
            AssetPaths.notificationIcon,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state.chats.isLoading) {
                  return const LoadingWidget();
                }

                if (state.chats.isFailure) {
                  return Center(
                    child: RetryWidget(
                      message:
                          state.chats.errorMessage ?? 'Something went wrong',
                      onRetry: () {
                        context.read<ChatCubit>().getChats();
                      },
                    ),
                  );
                }

                // No setState needed - BLoC handles state!
                if (state.chats.data?.isEmpty ?? true) {
                  return const EmptyStateWidget(
                    image: AssetPaths.emptyStateIcon,
                    text: 'No active chats',
                  );
                }

                // Extract chat IDs from your backend data
                final chatIds =
                    state.chats.data!.map((chat) => chat.id).toList();
                AppLogger.info('Backend Chat IDs: $chatIds');

                // If no valid chat IDs, show message
                if (chatIds.isEmpty) {
                  return const Center(
                    child: Text('No valid chat IDs found'),
                  );
                }

                final controller = _createController(chatIds);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<ChatCubit>().getChats();
                    },
                    child: StreamChannelListView(
                      controller: controller,
                      errorBuilder: (context, error) {
                        AppLogger.error('StreamChannelListView Error: $error');
                        return RetryWidget(
                          message: 'Unable to load chats',
                          onRetry: () {
                            context.read<ChatCubit>().getChats();
                          },
                        );
                      },
                      emptyBuilder: (context) {
                        return const EmptyStateWidget(
                          image: AssetPaths.activLogo,
                          text: 'No active chats',
                        );
                      },
                      loadingBuilder: (context) {
                        return const LoadingWidget();
                      },
                      itemBuilder: (context, channels, index, defaultWidget) {
                        final channel = channels[index];

                        // Find matching ChatModel for this channel
                        final chatModel = state.chats.data!.firstWhere(
                          (chat) => channel.cid == 'messaging:${chat.id}',
                          orElse: () => state.chats.data!.first, // fallback
                        );

                        return ChatTile(
                          channel: channel,
                          onTap: () {
                            _navigateToChat(channel, chatModel);
                          },
                        );
                      },
                      onChannelTap: (channel) {
                        AppLogger.info('Channel tapped: ${channel.cid}');
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _navigateToChat(Channel channel, ChatModel chatModel) {
    AppLogger.info('Navigating to chat: ${channel.cid} - ${chatModel.name}');

    context.pushNamed(
      AppRouteNames.chatDetailScreen,
      extra: {
        'chatModel': chatModel,
        'channel': channel,
      },
    );
  }
}

// Simple chat detail screen
