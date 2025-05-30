import 'package:activ/core/models/user_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    this.user = const DataState.initial(),
    this.isSearching = false,
    this.showSearchBar = false,
  });

  final DataState<UserModel> user;
  final bool isSearching;
  final bool showSearchBar;

  HomeState copyWith({
    DataState<UserModel>? user,
    bool? isSearching,
    bool? showSearchBar,
  }) {
    return HomeState(
      user: user ?? this.user,
      isSearching: isSearching ?? this.isSearching,
      showSearchBar: showSearchBar ?? this.showSearchBar,
    );
  }

  @override
  List<Object?> get props => [
        user,
        isSearching,
        showSearchBar,
      ];
}
