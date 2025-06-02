import 'package:activ/core/models/user_model.dart';
import 'package:activ/features/games/domain/games_repository.dart';
import 'package:activ/utils/helpers/repository_response.dart';

class GamesRepositoryImplementation implements GamesRepository {
  @override
  Future<RepositoryResponse<UserModel>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
