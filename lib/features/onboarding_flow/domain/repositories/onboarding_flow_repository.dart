import 'package:activ/core/models/auth_data_model.dart';
import 'package:activ/core/models/sport_model.dart';
import 'package:activ/core/models/sport_response_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/utils/helpers/repository_response.dart';
import 'package:image_picker/image_picker.dart';

abstract class OnboardingFlowRepository {
  Future<RepositoryResponse<bool>> onboarded();

  Future<RepositoryResponse<AuthData>> signIn(
    String email,
    String password,
  );

  Future<RepositoryResponse<AuthData>> signUp(
    String email,
    String password,
  );

  Future<RepositoryResponse<AuthData>> signInWithGoogle();
  Future<RepositoryResponse<AuthData>> signInWithApple();

  Future<RepositoryResponse<dynamic>> forgotPassword(String email);

  Future<RepositoryResponse<dynamic>> resetPassword(
    String code,
    String password,
  );

  Future<RepositoryResponse<List<SportModel>>> getAllSports();

  Future<RepositoryResponse<UserModel>> completeOnboarding(
    String firstName,
    String lastName,
    String? dateOfBirth,
    String? gender,
    String? phoneNumber,
    Map<String, double> interests,
    XFile? profilePicture,
  );
}
