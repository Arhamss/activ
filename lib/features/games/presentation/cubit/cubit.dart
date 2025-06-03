
import 'package:activ/features/games/domain/games_repository.dart';
import 'package:activ/features/games/presentation/cubit/state.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamesCubit extends Cubit<GamesState> {
  GamesCubit({required this.repository}) : super(const GamesState());

  final GamesRepository repository;

  Future<void> getUser() async {
    emit(state.copyWith(user: const DataState.loading()));

    final response = await repository.getUser();

    if (response.isSuccess) {
      emit(
        state.copyWith(
          user: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          user: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }
}
