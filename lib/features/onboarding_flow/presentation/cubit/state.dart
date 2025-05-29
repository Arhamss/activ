import 'package:activ/core/models/auth_data_model.dart';
import 'package:activ/core/models/sport_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingFlowState extends Equatable {
  const OnboardingFlowState({
    this.onboarded = const DataState.initial(),
    this.signIn = const DataState.initial(),
    this.signUp = const DataState.initial(),
    this.signInWithGoogle = const DataState.initial(),
    this.signInWithApple = const DataState.initial(),
    this.forgotPassword = const DataState.initial(),
    this.resetCode,
    this.resetPassword = const DataState.initial(),
    this.pinCodeEntered = false,
    this.detailsIndex = 2,
    this.imagePath,
    this.phoneNumber = '',
    this.firstName = '',
    this.lastName = '',
    this.dateOfBirth = '',
    this.gender = '',
    this.sports = const DataState.initial(),
    this.selectedInterests = const {},
    this.completeOnboarding = const DataState.initial(),
  });

  final DataState<bool> onboarded;
  final DataState<AuthData> signIn;
  final DataState<AuthData> signUp;
  final DataState<AuthData> signInWithGoogle;
  final DataState<AuthData> signInWithApple;
  final DataState<dynamic> forgotPassword;
  final String? resetCode;
  final DataState<dynamic> resetPassword;
  final bool pinCodeEntered;
  final int detailsIndex;
  final XFile? imagePath;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final DataState<List<SportModel>> sports;
  final Map<String, double> selectedInterests;
  final DataState<dynamic> completeOnboarding;

  OnboardingFlowState copyWith({
    DataState<bool>? onboarded,
    DataState<AuthData>? signIn,
    DataState<AuthData>? signUp,
    DataState<AuthData>? signInWithGoogle,
    DataState<AuthData>? signInWithApple,
    DataState<dynamic>? forgotPassword,
    String? resetCode,
    DataState<dynamic>? resetPassword,
    bool? pinCodeEntered,
    int? detailsIndex,
    XFile? imagePath,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    DataState<List<SportModel>>? sports,
    Map<String, double>? selectedInterests,
    DataState<dynamic>? completeOnboarding,
  }) {
    return OnboardingFlowState(
      onboarded: onboarded ?? this.onboarded,
      signIn: signIn ?? this.signIn,
      signUp: signUp ?? this.signUp,
      signInWithGoogle: signInWithGoogle ?? this.signInWithGoogle,
      signInWithApple: signInWithApple ?? this.signInWithApple,
      forgotPassword: forgotPassword ?? this.forgotPassword,
      resetCode: resetCode ?? this.resetCode,
      resetPassword: resetPassword ?? this.resetPassword,
      pinCodeEntered: pinCodeEntered ?? this.pinCodeEntered,
      detailsIndex: detailsIndex ?? this.detailsIndex,
      imagePath: imagePath ?? this.imagePath,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      sports: sports ?? this.sports,
      selectedInterests: selectedInterests ?? this.selectedInterests,
      completeOnboarding: completeOnboarding ?? this.completeOnboarding,
    );
  }

  @override
  List<Object?> get props => [
        onboarded,
        signIn,
        signUp,
        signInWithGoogle,
        signInWithApple,
        forgotPassword,
        resetPassword,
        resetCode,
        pinCodeEntered,
        detailsIndex,
        imagePath,
        phoneNumber,
        firstName,
        lastName,
        dateOfBirth,
        gender,
        sports,
        selectedInterests,
        completeOnboarding,
      ];
}
