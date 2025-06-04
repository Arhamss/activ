import 'package:activ/exports.dart';
import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/constants/time_duration_formatter.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    required this.chat,
    required this.onTap,
    this.lastMessage,
    super.key,
  });

  final ChatModel chat;
  final VoidCallback onTap;
  final String? lastMessage;

  @override
  Widget build(BuildContext context) {
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
                _getInitials(chat.name),
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
                    chat.name,
                    style: context.b1.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    lastMessage ?? '${chat.gameSport} at ${chat.gameAddress}',
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
                if (chat.unreadCount > 0)
                  Container(
                    height: 17,
                    width: 17,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.activeDetailsProgressBar,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      chat.unreadCount > 99
                          ? '99+'
                          : chat.unreadCount.toString(),
                      style: context.b2.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),

                // Formatted time
                Text(
                  _formatMessageTime(chat.gameDatetime),
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

  String _formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    final localDateTime = dateTime.toLocal();
    final difference = now.difference(localDateTime);

    if (difference.inDays == 0) {
      // Today - show time
      return TimeZoneHelper.formatTimeToHours(dateTime);
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
