import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/features/profile/domain/profile_repository.dart';

import 'package:activ/utils/helpers/repository_response.dart';

class ProfileRepositoryImplementation implements ProfileRepository {
  @override
  Future<RepositoryResponse<UserModel>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
