import 'package:activ/core/models/user_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  const SearchState({
    this.user = const DataState.initial(),
  });

  final DataState<UserModel> user;

  SearchState copyWith({
    DataState<UserModel>? user,
  }) {
    return SearchState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}
