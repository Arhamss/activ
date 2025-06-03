import 'package:activ/core/models/user_model.dart';
import 'package:activ/utils/helpers/repository_response.dart';

abstract class GamesRepository {
  Future<RepositoryResponse<UserModel>> getUser();
}
