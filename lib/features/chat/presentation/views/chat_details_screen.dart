import 'dart:io';
import 'package:activ/core/field_validators.dart';
import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/exports.dart';
import 'package:activ/utils/widgets/core_widgets/retry_widget.dart';
import 'package:activ/utils/widgets/core_widgets/dialog.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:activ/core/permissions/permission_manager.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({
    required this.chatModel,
    required this.channel,
    super.key,
  });

  final ChatModel chatModel;
  final Channel channel;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late final messageInputController = StreamMessageInputController();

  @override
  void initState() {
    super.initState();
    _ensureUserConnected();
  }

  Future<void> _ensureUserConnected() async {
    try {
      final currentUser = StreamChat.of(context).currentUser;
      if (currentUser == null) {
        // User not connected, show error
        ToastHelper.showErrorToast(
          'Unable to connect to chat. Please try again.',
        );
        context.pop(); // Go back to previous screen
      }
    } catch (e) {
      AppLogger.error('Error checking user connection: $e');
      ToastHelper.showErrorToast(
        'Unable to connect to chat. Please try again.',
      );
      context.pop();
    }
  }

  @override
  void dispose() {
    messageInputController.dispose();
    super.dispose();
  }

  String getMessageTime(DateTime createdAt) {
    final now = DateTime.now();
    final diff = now.difference(createdAt);
    if (diff.inMinutes < 1) {
      return 'Just now';
    }
    return '${createdAt.toLocal().hour.toString().padLeft(2, '0')}:${createdAt.toLocal().minute.toString().padLeft(2, '0')}';
  }

  Future<void> _pickImage() async {
    // Check if there's already an attachment
    if (messageInputController.attachments.isNotEmpty) {
      ToastHelper.showErrorToast(
        'Only one attachment is allowed. Please remove the existing attachment first.',
      );
      return;
    }

    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70, // Reduce quality to save memory
      maxWidth: 1024, // Limit max dimensions
      maxHeight: 1024,
    );

    if (image != null) {
      final file = File(image.path);
      final bytes = await file.readAsBytes();
      final size = bytes.length;

      if (size > 10 * 1024 * 1024) {
        ToastHelper.showErrorToast(
          'Image size too large. Please select an image under 10MB.',
        );
        return;
      }

      try {
        final attachment = Attachment(
          type: 'image',
          file: AttachmentFile(
            size: size,
            path: image.path,
          ),
        );
        messageInputController.addAttachment(attachment);
      } catch (e) {
        AppLogger.error('Error adding attachment: $e');
        ToastHelper.showErrorToast(
          'Error adding attachment. Please try again.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamChannel(
      channel: widget.channel,
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
                      crossAxisAlignment: isCurrentUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (!isCurrentUser) ...[
                          CircleAvatar(
                            radius: 20,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (message.user?.name != null &&
                                  !isCurrentUser) ...[
                                Text(
                                  message.user?.name ?? '',
                                  style: context.b2.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isCurrentUser
                                      ? AppColors.secondaryColor
                                      : AppColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: isCurrentUser
                                        ? const Radius.circular(16)
                                        : const Radius.circular(0),
                                    topRight: const Radius.circular(16),
                                    bottomLeft: const Radius.circular(16),
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
                                    const SizedBox(height: 4),
                                    if (message.attachments.isNotEmpty) ...[
                                      if (message.attachments.first.type ==
                                          'image') ...[
                                        StreamImageAttachment(
                                          message: message,
                                          image: message.attachments.first,
                                          constraints: const BoxConstraints(
                                            maxWidth: 300,
                                            maxHeight: 300,
                                          ),
                                        ),
                                      ],
                                      if (message.attachments.first.type ==
                                          'video') ...[
                                        StreamVideoAttachment(
                                          message: message,
                                          video: message.attachments.first,
                                          constraints: const BoxConstraints(
                                            maxWidth: 300,
                                            maxHeight: 300,
                                          ),
                                        ),
                                      ],
                                      if (message.attachments.first.type ==
                                          'file') ...[
                                        StreamFileAttachment(
                                          message: message,
                                          file: message.attachments.first,
                                          constraints: const BoxConstraints(
                                            maxWidth: 300,
                                          ),
                                        ),
                                      ],
                                    ],
                                    const SizedBox(height: 4),
                                    Text(
                                      message.text ?? '',
                                      style: context.b2.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: isCurrentUser
                                            ? AppColors.white
                                            : AppColors.chatText,
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
                                            color: isCurrentUser
                                                ? AppColors.white
                                                : AppColors.chatTimeText,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        if (isCurrentUser) ...[
                                          if (message.state ==
                                              MessageState.sending)
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
                            ],
                          ),
                        ),
                        if (isCurrentUser) ...[
                          const SizedBox(width: 8),
                          CircleAvatar(
                            radius: 20,
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
            StreamMessageInput(
              textInputAction: TextInputAction.newline,
              messageInputController: messageInputController,
              actionsLocation: ActionsLocation.rightInside,
              onMessageSent: (message) {
                // Message sent successfully
                AppLogger.info('Message sent: ${message.id}');
              },
              preMessageSending: (message) async {
                final currentUser = StreamChat.of(context).currentUser;
                if (currentUser == null) {
                  ToastHelper.showErrorToast(
                    'Unable to send message. Please try again.',
                  );
                  throw Exception('User not connected');
                }
                return message.copyWith(
                  user: currentUser,
                );
              },
              idleSendButton: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.greyShade3,
                      shape: BoxShape.circle,
                    ),
                    width: 42,
                    height: 42,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      AssetPaths.sendIcon,
                    ),
                  ),
                ],
              ),
              activeSendButton: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    width: 42,
                    height: 42,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      AssetPaths.sendIcon,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              showCommandsButton: false,
              useSystemAttachmentPicker: true,
              onAttachmentLimitExceed: (limit, error) {
                ToastHelper.showErrorToast(
                  'Only one attachment is allowed. Please remove the existing attachment first.',
                );
              },
              onError: (error, stackTrace) => ToastHelper.showErrorToast(
                '$error',
              ),
              maxAttachmentSize: 10 * 1024 * 1024,
              attachmentLimit: 1,
              actionsBuilder: (context, defaultActions) {
                return [
                  IconButton(
                    icon: SvgPicture.asset(
                      AssetPaths.cameraIcon,
                    ),
                    onPressed: _pickImage,
                  ),
                  ...defaultActions,
                ];
              },
              mediaAttachmentBuilder: (context, attachment, defaultWidget) {
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.file(
                    File(attachment.localUri.toString()),
                    width: 100,
                    height: 100,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
