import 'package:activ/exports.dart';
import 'package:activ/features/games/presentation/cubit/cubit.dart';
import 'package:activ/features/games/presentation/cubit/state.dart';
import 'package:activ/features/games/presentation/widgets/upcoming_game_tile.dart';
import 'package:activ/utils/widgets/core_widgets/retry_widget.dart';
import 'package:flutter/cupertino.dart';

class UpcomingGames extends StatefulWidget {
  const UpcomingGames({super.key});

  @override
  State<UpcomingGames> createState() => _UpcomingGamesState();
}

class _UpcomingGamesState extends State<UpcomingGames> {
  @override
  void initState() {
    super.initState();
    context.read<GamesCubit>().getMyUpcomingGames();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesCubit, GamesState>(
      builder: (context, state) {
        if (state.myUpcomingGames.isLoading) {
          return const LoadingWidget();
        }

        if (state.myUpcomingGames.isFailure) {
          return Center(
            child: RetryWidget(
              message: state.myUpcomingGames.errorMessage ??
                  'Error while fetching upcoming games',
              onRetry: () => context.read<GamesCubit>().getMyUpcomingGames(),
            ),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            return UpcomingGameTile(game: state.myUpcomingGames.data![index]);
          },
          itemCount: state.myUpcomingGames.data?.length ?? 0,
        );
      },
    );
  }
}
