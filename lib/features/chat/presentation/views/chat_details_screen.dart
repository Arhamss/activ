import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/exports.dart';
import 'package:activ/utils/widgets/core_widgets/retry_widget.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({
    required this.chatModel,
    required this.channel,
    super.key,
  });

  final ChatModel chatModel;
  final Channel channel;

  String getMessageTime(DateTime createdAt) {
    final now = DateTime.now();
    final diff = now.difference(createdAt);
    if (diff.inMinutes < 1) {
      return 'Just now';
    }
    return '${createdAt.toLocal().hour.toString().padLeft(2, '0')}:${createdAt.toLocal().minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return StreamChannel(
      channel: channel,
      child: Scaffold(
        appBar: activAppBar(
          context: context,
          title: 'Messages',
          onLeadingPressed: () => context.pop(),
          leadingIcon: const Icon(Icons.arrow_back),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamMessageListView(
                messageBuilder: (context, details, index, defaultWidget) {
                  final message = details.message;
                  final isCurrentUser = message.user?.id ==
                      StreamChat.of(context).currentUser?.id;

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisAlignment: isCurrentUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isCurrentUser) ...[
                          if (message.user?.name != null) ...[
                            Text(
                              message.user?.name ?? '',
                              style: context.b2.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.primaryColor,
                            child: Text(
                              message.user?.name.characters.first
                                      .toUpperCase() ??
                                  'U',
                              style: context.b2.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isCurrentUser
                                  ? AppColors.secondaryColor
                                  : AppColors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: isCurrentUser
                                    ? const Radius.circular(16)
                                    : const Radius.circular(0),
                                bottomRight: isCurrentUser
                                    ? const Radius.circular(0)
                                    : const Radius.circular(16),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: isCurrentUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  message.text ?? '',
                                  style: context.b2.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: isCurrentUser
                                        ? AppColors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      getMessageTime(
                                        message.createdAt.toLocal(),
                                      ),
                                      style: context.b2.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (isCurrentUser) ...[
                                      if (message.state == MessageState.sending)
                                        const Icon(
                                          Icons.check,
                                          size: 10,
                                          color: AppColors.white,
                                        )
                                      else if (message.state ==
                                          MessageState.sent)
                                        const Icon(
                                          Icons.done_all,
                                          size: 10,
                                          color: AppColors.white,
                                        ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isCurrentUser) ...[
                          const SizedBox(width: 8),
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.primaryColor,
                            child: Text(
                              message.user?.name.characters.first
                                      .toUpperCase() ??
                                  'U',
                              style: context.b2.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
                loadingBuilder: (context) {
                  return const LoadingWidget();
                },
                emptyBuilder: (context) {
                  return const EmptyStateWidget(
                    image: AssetPaths.emptyStateIcon,
                    text: 'No messages yet',
                    subtitle: 'Send a message to start the conversation',
                  );
                },
                errorBuilder: (context, error) {
                  return RetryWidget(
                    message: 'Unable to load messages',
                    onRetry: () {
                      // context.read<ChatCubit>().getMessages(channel);
                    },
                  );
                },
              ),
            ),
            const StreamMessageInput(),
          ],
        ),
      ),
    );
  }
}
