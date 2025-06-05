import 'package:activ/exports.dart';
import 'package:activ/constants/time_duration_formatter.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    required this.channel,
    required this.onTap,
    super.key,
  });

  final Channel channel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    AppLogger.info('Channel: ${channel.cid}');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.greyShade6.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            // Circular Avatar
            CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primaryColor,
              child: Text(
                _getInitials(channel.name ?? 'Chat'),
                style: context.b1.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    channel.name ?? 'Chat',
                    style: context.b1.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _getLastMessageText(),
                    style: context.b2.copyWith(
                      color: AppColors.chatTime,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // End Column - Unread Count and Time
            Column(
              children: [
                // Unread count (optional)
                if ((channel.state?.unreadCount ?? 0) > 0)
                  Container(
                    height: 17,
                    width: 17,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.activeDetailsProgressBar,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      (channel.state?.unreadCount ?? 0) > 99
                          ? '99+'
                          : (channel.state?.unreadCount ?? 0).toString(),
                      style: context.b2.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),

                // Formatted time
                Text(
                  _formatMessageTime(),
                  style: context.l3.copyWith(
                    color: AppColors.chatTime,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      return words[0][0].toUpperCase();
    }
    return 'C';
  }

  String _getLastMessageText() {
    final lastMessage = channel.state?.messages.isNotEmpty == true
        ? channel.state!.messages.first
        : null;

    if (lastMessage != null) {
      return lastMessage.text ?? 'No message';
    }

    // Fallback to custom data if available
    final extraData = channel.extraData;
    final sport = extraData['gameSport'] as String?;
    final address = extraData['gameAddress'] as String?;

    if (sport != null && address != null) {
      return '$sport at $address';
    }

    return 'New chat';
  }

  String _formatMessageTime() {
    final lastMessage = channel.state?.messages.isNotEmpty == true
        ? channel.state!.messages.first
        : null;

    var messageTime = lastMessage?.createdAt;

    // Fallback to channel creation time
    messageTime ??= channel.createdAt;

    if (messageTime == null) return '';

    final now = DateTime.now();
    final localDateTime = messageTime.toLocal();
    final difference = now.difference(localDateTime);

    if (difference.inDays == 0) {
      // Today - show time
      return TimeZoneHelper.formatTimeToHours(messageTime);
    } else if (difference.inDays == 1) {
      // Yesterday
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      // This week - show day name
      return [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun',
      ][localDateTime.weekday - 1];
    } else {
      // Older - show date
      return formatDateShort(localDateTime);
    }
  }
}

// Helper function to create the builder
Widget chatTileBuilder(
  BuildContext context,
  List<Channel> channels,
  int index,
  VoidCallback onTap,
) {
  if (index >= channels.length) return const SizedBox.shrink();

  return ChatTile(
    channel: channels[index],
    onTap: onTap,
  );
}
