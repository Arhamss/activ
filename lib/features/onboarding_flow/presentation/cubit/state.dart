import 'package:activ/core/models/auth_data_model.dart';
import 'package:activ/utils/helpers/data_state.dart';
import 'package:equatable/equatable.dart';

class OnboardingFlowState extends Equatable {
  const OnboardingFlowState({
    this.signIn = const DataState.initial(),
    this.signUp = const DataState.initial(),
    this.signInWithGoogle = const DataState.initial(),
    this.signInWithApple = const DataState.initial(),
    this.forgotPassword = const DataState.initial(),
    this.resetCode,
    this.resetPassword = const DataState.initial(),
    this.pinCodeEntered = false,
    this.detailsIndex = 0,
    this.imagePath = '',
    this.phoneNumber = '',
    this.firstName = '',
    this.lastName = '',
    this.dateOfBirth = '',
    this.gender = '',
    this.selectedInterests = const {},
  });

  final DataState<AuthData> signIn;
  final DataState<AuthData> signUp;
  final DataState<AuthData> signInWithGoogle;
  final DataState<AuthData> signInWithApple;
  final DataState<dynamic> forgotPassword;
  final String? resetCode;
  final DataState<dynamic> resetPassword;
  final bool pinCodeEntered;
  final int detailsIndex;
  final String imagePath;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final Map<String, int> selectedInterests;

  OnboardingFlowState copyWith({
    DataState<AuthData>? signIn,
    DataState<AuthData>? signUp,
    DataState<AuthData>? signInWithGoogle,
    DataState<AuthData>? signInWithApple,
    DataState<dynamic>? forgotPassword,
    String? resetCode,
    DataState<dynamic>? resetPassword,
    bool? pinCodeEntered,
    int? detailsIndex,
    String? imagePath,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    Map<String, int>? selectedInterests,
  }) {
    return OnboardingFlowState(
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
      selectedInterests: selectedInterests ?? this.selectedInterests,
    );
  }

  @override
  List<Object?> get props => [
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
        selectedInterests,
      ];
}
