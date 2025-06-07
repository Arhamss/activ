import 'package:activ/core/models/games/game_model.dart';
import 'package:activ/core/models/location_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class GamesState extends Equatable {
  const GamesState({
    this.levels = const [],
    this.selectedLocation,
    this.addGame = const DataState.initial(),
    this.upcomingGames = const DataState.initial(),
  });


  final List<String> levels;
  final LocationModel? selectedLocation;
  final DataState<void> addGame;
  final DataState<List<GameModel>> upcomingGames;

  GamesState copyWith({
    List<String>? levels,
    LocationModel? selectedLocation,
    DataState<void>? addGame,
    DataState<List<GameModel>>? upcomingGames,
  }) {
    return GamesState(
      levels: levels ?? this.levels,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      addGame: addGame ?? this.addGame,
      upcomingGames: upcomingGames ?? this.upcomingGames,
    );
  }

  @override
  List<Object?> get props => [
        levels,
        selectedLocation,
        addGame,
        upcomingGames,
      ];
}
