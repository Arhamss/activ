import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/features/chat/domain/chat_repository.dart';
import 'package:activ/utils/helpers/repository_response.dart';

class ChatRepositoryImplementation implements ChatRepository {
  @override
  Future<RepositoryResponse<List<ChatModel>>> getChats() {
    throw UnimplementedError();
  }
}
