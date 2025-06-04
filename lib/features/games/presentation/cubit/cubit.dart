import 'package:activ/core/models/location_model.dart';
import 'package:activ/features/games/domain/games_repository.dart';
import 'package:activ/features/games/presentation/cubit/state.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamesCubit extends Cubit<GamesState> {
  GamesCubit({required this.repository}) : super(const GamesState());

  final GamesRepository repository;

  Future<void> addGame(
    LocationModel location,
    String gameId,
    String fee,
    String gameLevel,
    int maxNumberOfPlayers,
    String? dateTime,
  ) async {
    emit(state.copyWith(addGame: const DataState.loading()));

    final response = await repository.addGame(
      location,
      gameId,
      fee,
      gameLevel,
      maxNumberOfPlayers,
      dateTime,
    );

    if (response.isSuccess) {
      emit(state.copyWith(addGame: const DataState.loaded()));
    } else {
      emit(
        state.copyWith(
          addGame: DataState.failure(error: response.message),
        ),
      );
    }
  }

  void setSelectedLocation(LocationModel location) {
    emit(state.copyWith(selectedLocation: location));
  }

  void setLevels(List<String> levels) {
    emit(state.copyWith(levels: levels));
  }

  void addLevel(String level) {
    emit(state.copyWith(levels: [...state.levels, level]));
  }

  void clearSelectedLocation() {
    emit(state.copyWith());
  }

  void removeLevel(String level) {
    emit(
      state.copyWith(
        levels: state.levels.where((e) => e != level).toList(),
      ),
    );
  }
}
