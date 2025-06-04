import 'package:activ/constants/asset_paths.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/games/presentation/cubit/cubit.dart';
import 'package:activ/features/games/presentation/cubit/state.dart';
import 'package:activ/features/games/presentation/widgets/add_game_bottomsheet.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:activ/utils/widgets/core_widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:activ/utils/widgets/core_widgets/app_bar.dart';
import 'package:flutter_svg/svg.dart';

class MyGamesScreen extends StatelessWidget {
  const MyGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GamesCubit, GamesState>(
      listenWhen: (previous, current) => previous.addGame != current.addGame,
      listener: (context, state) {
        if (state.addGame.isLoaded) {
          try {
            context.pop();
          } catch (e) {
            AppLogger.error('Error popping screen:', e);
          }
        }
        if (state.addGame.isFailure) {
          ToastHelper.showErrorToast(
            state.addGame.errorMessage ?? 'Error while adding game',
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: activAppBar(
          title: 'My Games',
          context: context,
          actionWidget: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ActivIconButton(
                backgroundColor: Colors.transparent,
                icon: SvgPicture.asset(
                  AssetPaths.notificationIcon,
                ),
              ),
              ActivIconButton(
                backgroundColor: Colors.transparent,
                icon: SvgPicture.asset(
                  AssetPaths.addIcon,
                ),
                onPressed: () => showModalBottomSheet(
                  useRootNavigator: true,
                  context: context,
                  builder: (context) => const AddGameBottomSheet(),
                  isScrollControlled: true,
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Activ My Games',
                style: context.h3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your my games journey starts here.',
                style: context.b1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
