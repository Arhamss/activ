import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/core/models/stream_chat/stream_chat_auth_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  const ChatState({
    this.chats = const DataState.initial(),
    this.streamChatAuth = const DataState.initial(),
  });

  final DataState<List<ChatModel>> chats;
  final DataState<StreamChatAuthModel> streamChatAuth;

  ChatState copyWith({
    DataState<List<ChatModel>>? chats,
    DataState<StreamChatAuthModel>? streamChatAuth,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      streamChatAuth: streamChatAuth ?? this.streamChatAuth,
    );
  }

  @override
  List<Object?> get props => [
        chats,
        streamChatAuth,
      ];
}
