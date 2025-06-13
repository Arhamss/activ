import 'package:activ/core/api_service/api_service.dart';
import 'package:activ/core/app_preferences/app_preferences.dart';
import 'package:activ/core/di/injector.dart';
import 'package:activ/core/endpoints/endpoints.dart';
import 'package:activ/core/models/location_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/core/models/user_model/user_response_model.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/home/domain/home_repository.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:activ/utils/helpers/repository_response.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class HomeRepositoryImplementation implements HomeRepository {
  HomeRepositoryImplementation({
    ApiService? apiService,
    AppPreferences? baseStorage,
  })  : _apiService = apiService ?? ApiService(),
        _cache = baseStorage ?? Injector.resolve<AppPreferences>();

  final ApiService _apiService;
  final AppPreferences _cache;

  @override
  Future<RepositoryResponse<UserModel>> getUser() async {
    final userId = _cache.getUserId();

    if (userId == null) {
      return RepositoryResponse(
        isSuccess: false,
        message: 'User ID not found',
      );
    }

    // final userModel = _cache.getUserModel();

    // if (userModel != null) {
    //   return RepositoryResponse(
    //     isSuccess: true,
    //     data: userModel,
    //   );
    // }

    try {
      final response = await _apiService.get(Endpoints.getUser);

      if (response.statusCode == 200) {
        final result = UserResponseModel.parseResponse(response);

        //_cache.setUserModel(result.response?.data?.user);
        _cache.setUserId(result.response?.data?.user.id ?? '');

        return RepositoryResponse(
          isSuccess: true,
          data: result.response?.data?.user,
        );
      } else {
        return RepositoryResponse(
          isSuccess: false,
          message: response.data['message'] as String,
        );
      }
    } catch (e) {
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  Future<void> createAndConnectStreamUser({
    required BuildContext context,
    required UserModel userModel,
  }) async {
    try {
      final client = StreamChatCore.of(context).client;

      await client.disconnectUser();

      await client.connectUser(
        userModel.toStreamChatUser(),
        userModel.getstreamUserId,
      );
    } catch (e, s) {
      AppLogger.error('Error connecting or creating user in Stream', e, s);
      rethrow;
    }
  }

  @override
  Future<RepositoryResponse<void>> updateUserLocationFromPoints(
    LocationModel location,
  ) async {
    try {
      final queryParams = {
        'lat': location.latitude,
        'lng': location.longitude,
        'city': location.city,
      };

      final response = await _apiService.patch(
        Endpoints.updateUserLocation,
        queryParams,
      );

      if (response.statusCode == 200) {
        return RepositoryResponse(
          isSuccess: true,
        );
      } else {
        return RepositoryResponse(
          isSuccess: false,
          message: response.data['message'] as String,
        );
      }
    } catch (e) {
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
