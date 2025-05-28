import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/domain/repositories/onboarding_flow_repository.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingFlowCubit extends Cubit<OnboardingFlowState> {
  OnboardingFlowCubit({required this.repository})
      : super(const OnboardingFlowState());

  final OnboardingFlowRepository repository;

  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(signIn: const DataState.loading()));
    try {
      final response = await repository.signIn(email, password);

      if (response.isSuccess) {
        emit(
          state.copyWith(
            signIn: DataState.loaded(
              data: response.data,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            signIn: DataState.failure(error: response.message),
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(signIn: DataState.failure(error: e.toString())));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(state.copyWith(signUp: const DataState.loading()));
    try {
      final response = await repository.signUp(email, password);

      if (response.isSuccess) {
        emit(
          state.copyWith(
            signUp: DataState.loaded(
              data: response.data,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            signUp: DataState.failure(error: response.message),
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(signUp: DataState.failure(error: e.toString())));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(signInWithGoogle: const DataState.loading()));
    try {
      final response = await repository.signInWithGoogle();

      if (response.isSuccess) {
        emit(
          state.copyWith(
            signInWithGoogle: DataState.loaded(
              data: response.data,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            signInWithGoogle: DataState.failure(error: response.message),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          signInWithGoogle: DataState.failure(error: e.toString()),
        ),
      );
    }
  }

  Future<void> signInWithApple() async {
    emit(state.copyWith(signInWithApple: const DataState.loading()));
    try {
      final response = await repository.signInWithApple();

      if (response.isSuccess) {
        emit(
          state.copyWith(
            signInWithApple: DataState.loaded(
              data: response.data,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            signInWithApple: DataState.failure(error: response.message),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          signInWithApple: DataState.failure(error: e.toString()),
        ),
      );
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(state.copyWith(forgotPassword: const DataState.loading()));
    try {
      final response = await repository.forgotPassword(email);
      AppLogger.info('Forgot password response: ${response.isSuccess}');

      if (response.isSuccess) {
        emit(
          state.copyWith(
            forgotPassword: const DataState.loaded(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            forgotPassword: const DataState.failure(error: 'boom'),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          forgotPassword: const DataState.failure(error: 'boom'),
        ),
      );
    }
  }

  Future<void> setResetCode(String code) async {
    emit(state.copyWith(resetCode: code));
  }

  Future<void> resetPassword(String code, String password) async {
    emit(state.copyWith(resetPassword: const DataState.loading()));
    AppLogger.info('Resetting password...');
    try {
      if (code.isEmpty) {
        emit(
          state.copyWith(
            resetPassword: const DataState.failure(
              error: 'Reset code is required',
            ),
          ),
        );
        return;
      }

      final response = await repository.resetPassword(code, password);
      AppLogger.info('Reset password response: ${response.isSuccess}');

      if (response.isSuccess) {
        AppLogger.info('Password reset successful');
        emit(
          state.copyWith(
            resetPassword: const DataState.loaded(),
          ),
        );
      } else {
        AppLogger.error('Password reset failed');
        emit(
          state.copyWith(
            resetPassword: const DataState.failure(error: 'boom'),
          ),
        );
      }
    } catch (e) {
      AppLogger.error('Error resetting password: $e');
      emit(
        state.copyWith(
          resetPassword: const DataState.failure(error: 'boom'),
        ),
      );
    }
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (image != null) {
        emit(state.copyWith(imagePath: image));
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error picking image:', e, stackTrace);
    }
  }

  Future<void> getAllSports() async {
    emit(state.copyWith(sports: const DataState.loading()));
    try {
      final response = await repository.getAllSports();
      if (response.isSuccess) {
        emit(state.copyWith(sports: DataState.loaded(data: response.data)));
      } else {
        emit(
          state.copyWith(sports: DataState.failure(error: response.message)),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          sports: DataState.failure(error: Localization.failedToLoadSports),
        ),
      );
    }
  }

  Future<void> checkOnboardingStatus() async {
    emit(
      state.copyWith(
        onboarded: const DataState.loading(),
      ),
    );
    
    final response = await repository.onboarded();

    if (response.isSuccess) {
      emit(
        state.copyWith(
          onboarded: DataState.loaded(data: response.data),
        ),
      );
    } else {
      emit(
        state.copyWith(
          onboarded: DataState.failure(error: response.message),
        ),
      );
    }
  }

  Future<void> completeOnboarding() async {
    emit(state.copyWith(completeOnboarding: const DataState.loading()));
    final response = await repository.completeOnboarding(
      state.firstName,
      state.lastName,
      state.dateOfBirth,
      state.gender,
      state.phoneNumber,
      state.selectedInterests,
      state.imagePath,
    );

    if (response.isSuccess) {
      emit(state.copyWith(completeOnboarding: const DataState.loaded()));
    } else {
      emit(
        state.copyWith(
          completeOnboarding: DataState.failure(error: response.message),
        ),
      );
    }
  }

  void setPinCodeEntered(bool value) {
    emit(state.copyWith(pinCodeEntered: value));
  }

  void resetSignUp() {
    emit(state.copyWith(signUp: const DataState.initial()));
  }

  void resetAllSignIn() {
    emit(state.copyWith(signIn: const DataState.initial()));
    emit(state.copyWith(signInWithGoogle: const DataState.initial()));
    emit(state.copyWith(signInWithApple: const DataState.initial()));
  }

  void resetForgotPassword() {
    emit(state.copyWith(forgotPassword: const DataState.initial()));
  }

  void resetResetPassword() {
    emit(state.copyWith(resetPassword: const DataState.initial()));
  }

  void setDetailsIndex(int index) {
    emit(state.copyWith(detailsIndex: index));
  }

  void setUserInfo({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String dateOfBirth,
  }) {
    emit(
      state.copyWith(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
      ),
    );
  }

  void setGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void addInterest(String sport, double rating) {
    final updatedInterests = Map<String, double>.from(state.selectedInterests);
    updatedInterests[sport] = rating;
    emit(state.copyWith(selectedInterests: updatedInterests));
  }

  void removeInterest(String sport) {
    final updatedInterests = Map<String, double>.from(state.selectedInterests);
    updatedInterests.remove(sport);
    emit(state.copyWith(selectedInterests: updatedInterests));
  }

  void resetDetailsIndex() {
    emit(state.copyWith(detailsIndex: 0));
  }
}
