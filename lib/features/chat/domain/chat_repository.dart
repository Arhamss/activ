import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/utils/helpers/repository_response.dart';

abstract class ChatRepository {
  Future<RepositoryResponse<UserModel>> getUser();
}
