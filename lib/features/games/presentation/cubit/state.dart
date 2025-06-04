import 'package:activ/core/models/location_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class GamesState extends Equatable {
  const GamesState({
    this.levels = const [],
    this.selectedLocation,
    this.addGame = const DataState.initial(),
  });

  
  final List<String> levels;
  final LocationModel? selectedLocation;
  final DataState<void> addGame;

  GamesState copyWith({
    List<String>? levels,
    LocationModel? selectedLocation,
    DataState<void>? addGame,
  }) {
    return GamesState(
      levels: levels ?? this.levels,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      addGame: addGame ?? this.addGame,
    );
  }

  @override
  List<Object?> get props => [
        levels,
        selectedLocation,
        addGame,
      ];
}
