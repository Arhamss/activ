import 'package:activ/core/models/user_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    this.user = const DataState.initial(),
  });

  final DataState<UserModel> user;

  HomeState copyWith({
    DataState<UserModel>? user,
  }) {
    return HomeState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}
