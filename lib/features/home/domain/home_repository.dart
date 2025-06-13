import 'package:activ/core/models/location_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/utils/helpers/repository_response.dart';

abstract class HomeRepository {
  Future<RepositoryResponse<UserModel>> getUser();
  Future<RepositoryResponse<void>> updateUserLocationFromPoints(
    LocationModel location,
  );
}
