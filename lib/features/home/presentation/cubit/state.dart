import 'package:activ/core/models/location_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    this.user = const DataState.initial(),
    this.isSearching = false,
    this.levels = const [],
    this.selectedLocation,
    this.addGame = const DataState.initial(),
  });

  final DataState<UserModel> user;
  final bool isSearching;
  final List<String> levels;
  final LocationModel? selectedLocation;
  final DataState<void> addGame;

  HomeState copyWith({
    DataState<UserModel>? user,
    bool? isSearching,
    bool? showSearchBar,
    List<String>? levels,
    LocationModel? selectedLocation,
    DataState<void>? addGame,
  }) {
    return HomeState(
      user: user ?? this.user,
      isSearching: isSearching ?? this.isSearching,
      levels: levels ?? this.levels,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      addGame: addGame ?? this.addGame,
    );
  }

  @override
  List<Object?> get props => [
        user,
        isSearching,
        levels,
        selectedLocation,
        addGame,
      ];
}
