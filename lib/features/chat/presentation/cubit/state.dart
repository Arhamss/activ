import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  const ChatState({
    this.chats = const DataState.initial(),
  });

  final DataState<List<ChatModel>> chats;

  ChatState copyWith({
    DataState<List<ChatModel>>? chats,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
    );
  }

  @override
  List<Object?> get props => [
        chats,
      ];
}
