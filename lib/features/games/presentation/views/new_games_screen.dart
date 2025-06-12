import 'package:activ/constants/asset_paths.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/games/presentation/cubit/cubit.dart';
import 'package:activ/features/games/presentation/cubit/state.dart';
import 'package:activ/features/games/presentation/widgets/add_game_bottomsheet.dart';
import 'package:activ/features/games/presentation/widgets/upcoming_game_tile.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:activ/utils/widgets/core_widgets/icon_button.dart';
import 'package:activ/utils/widgets/core_widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:activ/utils/widgets/core_widgets/app_bar.dart';
import 'package:flutter_svg/svg.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GamesCubit>().getMyGames();
  }

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
          title: 'New Game',
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
                  builder: (context) =>  AddGameBottomSheet(),
                  isScrollControlled: true,
                ),
              ),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: AppColors.white,
              child: BlocBuilder<GamesCubit, GamesState>(
                builder: (context, state) {
                  if (state.myGames.isLoading) {
                    return const LoadingWidget();
                  }

                  if (state.myGames.isFailure) {
                    return Center(
                      child: RetryWidget(
                        message: state.myGames.errorMessage ??
                            'Error while fetching upcoming games',
                        onRetry: () => context.read<GamesCubit>().getMyGames(),
                      ),
                    );
                  }

                  if (state.myGames.data?.isEmpty ?? true) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: EmptyStateWidget(
                        image: AssetPaths.emptyStateIcon,
                        spacing: 32,
                        text: 'No games found at the moment!',
                        subtitle:
                            'Check back later or try exploring a different location.',
                      ),
                    );
                  }
                  return Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 16),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: 16,
                              bottom: 8,
                            ),
                            child: Text(
                              'Planned Games',
                              style: context.b1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => UpcomingGameTile(
                              game: state.myGames.data![index],
                            ),
                            childCount: state.myGames.data?.length ?? 0,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 100),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
