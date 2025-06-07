import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/core/models/stream_chat/stream_chat_auth_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/utils/helpers/repository_response.dart';

abstract class ChatRepository {
  Future<RepositoryResponse<List<ChatModel>>> getChats();
  Future<RepositoryResponse<StreamChatAuthModel>> getStreamChatAuth();
}
