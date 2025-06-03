import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/features/search/domain/search_repository.dart';
import 'package:activ/utils/helpers/repository_response.dart';

class SearchRepositoryImplementation implements SearchRepository {
  @override
  Future<RepositoryResponse<UserModel>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
