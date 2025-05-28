import 'dart:convert';
import 'dart:math';

import 'package:activ/core/api_service/api_service.dart';
import 'package:activ/core/api_service/app_api_exception.dart';
import 'package:activ/core/app_preferences/app_preferences.dart';
import 'package:activ/core/di/injector.dart';
import 'package:activ/core/endpoints/endpoints.dart';
import 'package:activ/core/models/api_response/api_response_model.dart';
import 'package:activ/core/models/api_response/base_api_response.dart';
import 'package:activ/core/models/auth_data_model.dart';
import 'package:activ/core/models/sport_model.dart';
import 'package:activ/core/models/sport_response_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/core/models/user_model/user_response_model.dart';
import 'package:activ/features/onboarding_flow/domain/repositories/onboarding_flow_repository.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:activ/utils/helpers/repository_response.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class OnboardingFlowRepositoryImpl implements OnboardingFlowRepository {
  OnboardingFlowRepositoryImpl({
    ApiService? apiService,
    AppPreferences? baseStorage,
  })  : _apiService = apiService ?? ApiService(),
        _cache = baseStorage ?? Injector.resolve<AppPreferences>();

  final ApiService _apiService;
  final AppPreferences _cache;

  @override
  Future<RepositoryResponse<bool>> onboarded() async {
    try {
      final response = await _apiService.get(Endpoints.onboarded);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final isOnboarded = data['data']['onboarded'] as bool;

        AppLogger.info(
          'Onboarded status: $isOnboarded',
        );

        return RepositoryResponse(
          isSuccess: true,
          data: isOnboarded,
        );
      } else {
        final error = response.data is Map<String, dynamic> &&
                response.data['error'] is String
            ? response.data['error'] as String
            : 'Unknown error';

        return RepositoryResponse(
          isSuccess: false,
          message: error,
        );
      }
    } catch (e, s) {
      AppLogger.error('Onboarded exception:', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: extractApiErrorMessage(e, 'Onboarded check failed'),
      );
    }
  }

  @override
  Future<RepositoryResponse<AuthData>> signIn(
    String email,
    String password,
  ) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final result = AuthData.parseResponse(response);
      final authData = result.response?.data;

      if (result.isSuccess && authData != null) {
        _cache
          ..setToken(authData.token)
          ..setUserId(authData.id);

        AppLogger.info('Sign in successful: ${authData.refreshToken}');

        return RepositoryResponse(
          isSuccess: true,
          data: authData,
        );
      } else {
        AppLogger.info('Sign in failed: ${result.error}');
        return RepositoryResponse(
          isSuccess: false,
          message: result.error ?? 'Sign in failed',
        );
      }
    } catch (e, s) {
      AppLogger.error('Sign in exception:', e, s);

      return RepositoryResponse(
        isSuccess: false,
        message: extractApiErrorMessage(e, 'Sign in failed'),
      );
    }
  }

  @override
  Future<RepositoryResponse<AuthData>> signUp(
    String email,
    String password,
  ) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.signup,
        data: {
          'email': email,
          'password': password,
        },
      );

      final result = AuthData.parseResponse(response);
      final authData = result.response?.data;

      if (result.isSuccess && authData != null) {
        _cache
          ..setToken(authData.token)
          ..setUserId(authData.id);

        AppLogger.info('Signup successful: ${authData.refreshToken}');
        return RepositoryResponse(
          isSuccess: true,
          data: authData,
        );
      } else {
        AppLogger.error('Signup failed: ${result.error}');
        return RepositoryResponse(
          isSuccess: false,
          message: result.error ?? 'Sign up failed',
        );
      }
    } catch (e, s) {
      AppLogger.error('Signup exception:', e, s);

      return RepositoryResponse(
        isSuccess: false,
        message: extractApiErrorMessage(e, 'Sign up failed'),
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> forgotPassword(String email) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.forgotPassword,
        data: {
          'email': email,
        },
      );

      final result = ResponseModel.fromApiResponse<BaseApiResponse<void>>(
        response,
        (json) => BaseApiResponse<void>.fromJson(json, (_) {}),
      );

      if (result.isSuccess) {
        AppLogger.info('Password reset email sent to: $email');
        return RepositoryResponse(
          isSuccess: true,
          data: true,
          message: 'Password reset email sent',
        );
      } else {
        AppLogger.info('Password reset failed: ${result.error}');
        return RepositoryResponse(
          isSuccess: false,
          message: result.error ?? 'Failed to reset password',
          data: false,
        );
      }
    } catch (e, s) {
      AppLogger.error('Password reset exception:', e, s);

      return RepositoryResponse(
        isSuccess: false,
        message: extractApiErrorMessage(e, 'Failed to reset Password'),
        data: false,
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> resetPassword(
    String code,
    String password,
  ) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.resetPassword,
        data: {
          'token': code,
          'newPassword': password,
        },
      );

      final result = ResponseModel.fromApiResponse<BaseApiResponse<void>>(
        response,
        (json) => BaseApiResponse<void>.fromJson(json, (_) {}),
      );

      if (result.isSuccess) {
        AppLogger.info('Password reset successful');
        return RepositoryResponse(
          isSuccess: true,
          data: true,
          message: 'Password reset successful',
        );
      } else {
        AppLogger.info('Password reset failed: ${result.error}');
        return RepositoryResponse(
          isSuccess: false,
          message: result.error ?? 'Failed to reset password',
          data: false,
        );
      }
    } catch (e, s) {
      AppLogger.error('Password reset exception:', e, s);

      return RepositoryResponse(
        isSuccess: false,
        message: extractApiErrorMessage(e, 'Failed to reset password'),
        data: false,
      );
    }
  }

  @override
  Future<RepositoryResponse<AuthData>> signInWithApple() async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final identityToken = appleCredential.identityToken;

      if (identityToken == null) {
        throw AppApiException('Identity token is null');
      }

      final response = await _apiService.post(
        endpoint: Endpoints.signinWithApple,
        data: {
          'appleId': identityToken,
          'email': appleCredential.email,
          'name': '${appleCredential.givenName} ${appleCredential.familyName}',
        },
      );

      final result = AuthData.parseResponse(response);
      final authData = result.response?.data;

      if (result.isSuccess && authData != null) {
        _cache
          ..setToken(authData.token)
          ..setUserId(authData.id);

        AppLogger.info('Apple Sign in successful: ${authData.refreshToken}');

        return RepositoryResponse(
          isSuccess: true,
          data: authData,
        );
      } else {
        AppLogger.info('Apple Sign in failed: ${result.error}');
        return RepositoryResponse(
          isSuccess: false,
          message: result.error ?? 'Apple Sign in failed',
        );
      }
    } catch (e, s) {
      AppLogger.error('Apple Sign in exception:', e, s);

      return RepositoryResponse(
        isSuccess: false,
        message: extractApiErrorMessage(e, 'Apple Sign in failed'),
      );
    }
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<RepositoryResponse<AuthData>> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      final account = await googleSignIn.signIn();
      if (account == null) {
        throw AppApiException('Google sign in was cancelled');
      }

      final idToken = account.id;

      final response = await _apiService.post(
        endpoint: Endpoints.signinWithGoogle,
        data: {
          'idToken': idToken,
        },
      );
      final result = AuthData.parseResponse(response);
      final authData = result.response?.data;
      if (result.isSuccess && authData != null) {
        _cache
          ..setToken(authData.token)
          ..setUserId(authData.id);

        AppLogger.info('Sign in successful: ${authData.refreshToken}');

        return RepositoryResponse(
          isSuccess: true,
          data: authData,
        );
      } else {
        AppLogger.info('Sign in failed: ${result.error}');
        return RepositoryResponse(
          isSuccess: false,
          message: result.error ?? 'Sign in failed',
        );
      }
    } catch (e, s) {
      AppLogger.error('Sign in exception:', e, s);

      return RepositoryResponse(
        isSuccess: false,
        message: extractApiErrorMessage(e, 'Sign in failed'),
      );
    }
  }

  @override
  Future<RepositoryResponse<List<SportModel>>> getAllSports() async {
    try {
      final response = await _apiService.get(Endpoints.getAllSports);

      final result = SportsResponseModel.parseResponse(response);

      if (result.isSuccess && result.response != null) {
        return RepositoryResponse(
          isSuccess: true,
          data: result.response!.data!.sports,
        );
      } else {
        return RepositoryResponse(
          isSuccess: false,
          message: result.error ?? 'Get all sports failed',
        );
      }
    } catch (e, s) {
      AppLogger.error('Get all sports exception:', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: extractApiErrorMessage(e, 'Get all sports failed'),
      );
    }
  }

  @override
  Future<RepositoryResponse<UserModel>> completeOnboarding(
    String firstName,
    String lastName,
    String? dateOfBirth,
    String? gender,
    String? phoneNumber,
    Map<String, double> interests,
    XFile? profilePicture,
  ) async {
    try {
      final sports = interests.entries
          .map(
            (entry) => {
              'sportId': entry.key,
              'rating': entry.value.toInt(),
            },
          )
          .toList();

      final payload = {
        'firstName': firstName,
        'lastName': lastName,
        'dob': dateOfBirth != null
            ? DateFormat('dd/MM/yyyy').parse(dateOfBirth).toIso8601String()
            : null,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'sports': sports,
      };

      late final Response response;

      if (profilePicture != null) {
        final multipartData = {
          ...payload,
          'image': await MultipartFile.fromFile(
            profilePicture.path,
            filename: profilePicture.name,
          ),
        };
        AppLogger.info('Complete onboarding multipart request: $multipartData');
        response = await _apiService.patchMultipart(
          Endpoints.completeOnboarding,
          multipartData,
        );
      } else {
        AppLogger.info('Complete onboarding JSON request: $payload');
        response = await _apiService.patch(
          Endpoints.completeOnboarding,
          payload,
        );
      }

      final result = UserResponseModel.parseResponse(response);

      if (result.isSuccess) {
        return RepositoryResponse(
          isSuccess: true,
          data: result.response?.data?.user,
        );
      } else {
        return RepositoryResponse(
          isSuccess: false,
          message: result.error,
        );
      }
    } catch (e, s) {
      AppLogger.error('Complete onboarding exception:', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: extractApiErrorMessage(e, 'Complete onboarding failed'),
      );
    }
  }
}
