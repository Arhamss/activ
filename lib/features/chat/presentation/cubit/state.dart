import 'package:activ/core/models/user_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  const ChatState({
    this.user = const DataState.initial(),
  });

  final DataState<UserModel> user;

  ChatState copyWith({
    DataState<UserModel>? user,
  }) {
    return ChatState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}
