import 'package:activ/constants/asset_paths.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/games/presentation/cubit/cubit.dart';
import 'package:activ/features/games/presentation/cubit/state.dart';
import 'package:activ/features/games/presentation/views/past_games.dart';
import 'package:activ/features/games/presentation/views/upcoming_games.dart';
import 'package:activ/utils/widgets/core_widgets/icon_button.dart';
import 'package:activ/utils/widgets/core_widgets/sliding_tab.dart';
import 'package:flutter/material.dart';
import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:activ/utils/widgets/core_widgets/app_bar.dart';
import 'package:flutter_svg/svg.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: activAppBar(
        title: 'Games',
        context: context,
        actionWidget: ActivIconButton(
          backgroundColor: Colors.transparent,
          icon: SvgPicture.asset(
            AssetPaths.notificationIcon,
          ),
        ),
      ),
      body: BlocBuilder<GamesCubit, GamesState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                ActivSlidingTab(
                  height: 50,
                  shortenWidth: true,
                  textOne: 'Upcoming Games',
                  textTwo: 'Past Games',
                  onTapOne: () {
                    context.read<GamesCubit>().setSelectedTab(0);
                  },
                  onTapTwo: () {
                    context.read<GamesCubit>().setSelectedTab(1);
                  },
                  selectedColor: AppColors.activeDetailsProgressBar,
                  textStyle: context.b1.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                  initialIndex: state.selectedTab,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: state.selectedTab == 0
                      ? const UpcomingGames()
                      : const PastGames(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
