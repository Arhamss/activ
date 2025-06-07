import 'package:activ/constants/app_colors.dart';
import 'package:activ/core/models/games/game_model.dart';
import 'package:activ/exports.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingGameTile extends StatelessWidget {
  const UpcomingGameTile({required this.game, super.key});

  final GameModel game;

  String _formatGameDateTime(DateTime dateTime) {
    final localDateTime = dateTime.toLocal();

    // Get day with ordinal suffix
    final day = localDateTime.day;
    String dayWithSuffix;
    if (day >= 11 && day <= 13) {
      dayWithSuffix = '${day}th';
    } else {
      switch (day % 10) {
        case 1:
          dayWithSuffix = '${day}st';
        case 2:
          dayWithSuffix = '${day}nd';
        case 3:
          dayWithSuffix = '${day}rd';
        default:
          dayWithSuffix = '${day}th';
      }
    }

    // Format the complete date string
    final monthName = DateFormat('MMMM').format(localDateTime);
    final dayName = DateFormat('EEEE').format(localDateTime);
    final time = DateFormat('h:mma').format(localDateTime).toLowerCase();

    return '$dayWithSuffix $monthName - $dayName, $time';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: AppColors.upcomingGameBorder,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${game.sport} Match',
                  style: context.b1.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  AssetPaths.chatGroupIcon,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                color: AppColors.upcomingGameDivider,
                height: 1,
              ),
            ),
            _GameDetails(
              icon: AssetPaths.calendarIcon,
              text: _formatGameDateTime(game.datetime),
            ),
            _GameDetails(
              icon: AssetPaths.levelIcon,
              text: 'Level - ${game.level}',
            ),
            _GameDetails(
              icon: AssetPaths.locationIcon,
              text: game.address.split(',').first,
            ),
            _GameDetails(
              icon: AssetPaths.feesIcon,
              text: 'Fees \$${(game.feeCents / 100).toInt()}',
            ),
            const SizedBox(height: 16),
            ActivButton(
              textStyle: context.b1.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.white,
              ),
              padding: const EdgeInsetsDirectional.symmetric(vertical: 14),
              backgroundColor: AppColors.seePlayersButton,
              isLoading: false,
              onPressed: () {},
              text: 'See Players',
            ),
          ],
        ),
      ),
    );
  }
}

class _GameDetails extends StatelessWidget {
  const _GameDetails({required this.icon, required this.text, super.key});
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Fixed size container for consistent icon alignment
          SizedBox(
            width: 24,
            height: 24,
            child: Center(
              child: SvgPicture.asset(
                icon,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: context.b1.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
