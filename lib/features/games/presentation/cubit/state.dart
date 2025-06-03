import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class GamesState extends Equatable {
  const GamesState({
    this.user = const DataState.initial(),
  });

  final DataState<UserModel> user;

  GamesState copyWith({
    DataState<UserModel>? user,
  }) {
    return GamesState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}
