import 'package:activ/core/models/user_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.user = const DataState.initial(),
  });

  final DataState<UserModel> user;

  ProfileState copyWith({
    DataState<UserModel>? user,
  }) {
    return ProfileState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}
