import 'package:activ/core/models/games/game_model.dart';
import 'package:activ/core/models/games/past_game_model.dart';
import 'package:activ/core/models/location_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class GamesState extends Equatable {
  const GamesState({
    this.levels = const [],
    this.selectedLocation,
    this.addGame = const DataState.initial(),
    this.myGames = const DataState.initial(),
    this.myUpcomingGames = const DataState.initial(),
    this.myPastGames = const DataState.initial(),
    this.selectedTab = 0,
  });

  final List<String> levels;
  final LocationModel? selectedLocation;
  final DataState<void> addGame;
  final DataState<List<GameModel>> myGames;
  final DataState<List<GameModel>> myUpcomingGames;
  final DataState<List<PastGameModel>> myPastGames;
  final int selectedTab;
  GamesState copyWith({
    List<String>? levels,
    LocationModel? selectedLocation,
    DataState<void>? addGame,
    DataState<List<GameModel>>? myGames,
    DataState<List<GameModel>>? myUpcomingGames,
    DataState<List<PastGameModel>>? myPastGames,
    int? selectedTab,
  }) {
    return GamesState(
      levels: levels ?? this.levels,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      addGame: addGame ?? this.addGame,
      myGames: myGames ?? this.myGames,
      myUpcomingGames: myUpcomingGames ?? this.myUpcomingGames,
      myPastGames: myPastGames ?? this.myPastGames,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [
        levels,
        selectedLocation,
        addGame,
        myGames,
        myUpcomingGames,
        myPastGames,
        selectedTab,
      ];
}
