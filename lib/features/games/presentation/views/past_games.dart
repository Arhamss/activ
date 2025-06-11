import 'package:activ/exports.dart';
import 'package:activ/features/games/presentation/cubit/cubit.dart';
import 'package:activ/features/games/presentation/cubit/state.dart';
import 'package:activ/features/games/presentation/widgets/past_game_tile.dart';
import 'package:activ/features/games/presentation/widgets/upcoming_game_tile.dart';
import 'package:activ/utils/widgets/core_widgets/retry_widget.dart';
import 'package:flutter/cupertino.dart';

class PastGames extends StatefulWidget {
  const PastGames({super.key});

  @override
  State<PastGames> createState() => _PastGamesState();
}

class _PastGamesState extends State<PastGames> {
  @override
  void initState() {
    super.initState();
    context.read<GamesCubit>().getMyPastGames();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesCubit, GamesState>(
      builder: (context, state) {
        if (state.myPastGames.isLoading) {
          return const LoadingWidget();
        }

        if (state.myPastGames.isFailure) {
          return Center(
            child: RetryWidget(
              message: state.myPastGames.errorMessage ??
                  'Error while fetching past games',
              onRetry: () => context.read<GamesCubit>().getMyPastGames(),
            ),
          );
        }

        if (state.myPastGames.data?.isEmpty ?? true) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: EmptyStateWidget(
              image: AssetPaths.emptyStateIcon,
              spacing: 32,
              text: 'No games found at the moment!',
              subtitle: 'Check back later or try exploring a different location.',
            ),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            return PastGameTile(game: state.myPastGames.data![index]);
          },
          itemCount: state.myPastGames.data?.length ?? 0,
        );
      },
    );
  }
}
