import 'package:activ/core/models/user_model.dart';
import 'package:activ/features/home/domain/home_repository.dart';
import 'package:activ/utils/helpers/repository_response.dart';

class HomeRepositoryImplementation implements HomeRepository {
  @override
  Future<RepositoryResponse<UserModel>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
