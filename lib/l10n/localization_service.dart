import 'package:activ/exports.dart';
import 'package:activ/l10n/arb/app_localizations.dart';

class Localization {
  static AppLocalizations? _localizations;

  /// Initialize the localization instance (called once in your app lifecycle).
  static void init(BuildContext context) {
    _localizations = AppLocalizations.of(context);
  }

  /// Access the localization instance.
  static AppLocalizations get _instance {
    if (_localizations == null) {
      throw Exception(
        'Localization.init must be called before accessing localized strings.',
      );
    }
    return _localizations!;
  }

  ///----------------- General App Strings (from app_en.arb) -----------------///

  static String get intro1Title => _instance.intro1Title;

  static String get intro1Description => _instance.intro1Description;

  static String get intro2Title => _instance.intro2Title;

  static String get intro2Description => _instance.intro2Description;

  static String get intro3Title => _instance.intro3Title;

  static String get intro3Description => _instance.intro3Description;

  static String get skipText => _instance.skipText;

  static String get nextText => _instance.nextText;

  static String get getStartedText => _instance.getStartedText;

  static String get appName => _instance.appName;

  static String get signIn => _instance.signIn;

  static String get signUp => _instance.signUp;

  static String get email => _instance.email;

  static String get password => _instance.password;

  static String get newPassword => _instance.newPassword;

  static String get confirmPassword => _instance.confirmPassword;

  static String get forgotPassword => _instance.forgotPassword;

  static String get resetPassword => _instance.resetPassword;

  static String get enterResetCode => _instance.enterResetCode;

  static String get continueText => _instance.continueText;

  static String get submit => _instance.submit;

  static String get cancel => _instance.cancel;

  static String get home => _instance.home;

  static String get settings => _instance.settings;

  static String get profile => _instance.profile;

  static String get logout => _instance.logout;

  static String get orConnectWith => _instance.orConnectWith;

  static String get createAccount => _instance.createAccount;

  static String get alreadyHaveAccount => _instance.alreadyHaveAccount;

  static String get dontHaveAccount => _instance.dontHaveAccount;

  static String get fieldRequired => _instance.fieldRequired;

  static String get passwordRequired => _instance.passwordRequired;

  static String get emailRequired => _instance.emailRequired;

  static String get invalidEmail => _instance.invalidEmail;

  static String get passwordTooShort => _instance.passwordTooShort;

  static String get passwordMismatch => _instance.passwordMismatch;

  static String get errorOccurred => _instance.errorOccurred;

  static String get success => _instance.success;

  static String get oops => _instance.oops;

  static String get retry => _instance.retry;

  static String get ok => _instance.ok;

  static String get yes => _instance.yes;

  static String get no => _instance.no;

  static String get search => _instance.search;

  static String get loading => _instance.loading;

  static String get pleaseWait => _instance.pleaseWait;

  static String get noInternetConnection => _instance.noInternetConnection;

  static String get timeoutError => _instance.timeoutError;

  static String get unknownError => _instance.unknownError;

  static String get featureComingSoon => _instance.featureComingSoon;

  static String get helloWorld => _instance.helloWorld;

  static String get dontHaveAnAccount => _instance.dontHaveAnAccount;

  static String get forgotPasswordSubtitle => _instance.forgotPasswordSubtitle;

  static String get resetCodeSubtitle => _instance.resetCodeSubtitle;

  static String get createANewOne => _instance.createANewOne;

  static String get signInToContinue => _instance.signInToContinue;

  static String get signUpToContinue => _instance.signUpToContinue;

  static String get continieWithApple => _instance.continueWithApple;

  static String get continueWithGoogle => _instance.continueWithGoogle;

  static String get passwordResetSuccessTitle =>
      _instance.passwordResetSuccessTitle;

  static String get passwordResetSuccessMessage =>
      _instance.passwordResetSuccessMessage;

  static String get codeSentToEmail => _instance.codeSentToEmail;

  static String get failedToSendPasswordRecovery =>
      _instance.failedToSendPasswordRecovery;

  static String get failedToResetPassword => _instance.failedToResetPassword;

  static String get failedToSignInUser => _instance.failedToSignInUser;

  static String get failedToSignUpUser => _instance.failedToSignUpUser;

  static String get failedToSignInWithGoogle =>
      _instance.failedToSignInWithGoogle;

  static String get successfullySignedInWithGoogle =>
      _instance.successfullySignedInWithGoogle;

  static String get yourName => _instance.yourName;

  static String get resetCodeSet => _instance.resetCodeSet;

  static String get codeMustBe6Digits => _instance.codeMustBe6Digits;

  static String get pleaseEnterResetCode => _instance.pleaseEnterResetCode;

  static String get byContinuingYouAgreeToOur =>
      _instance.byContinuingYouAgreeToOur;

  static String get termsOfService => _instance.termsOfServiceLink;

  static String get verify => _instance.verify;

  static String get resetPasswordSubtitle => _instance.resetPasswordSubtitle;

  static String get signInSuccess => _instance.signInSuccess;

// --- End of General App Strings ---

// Add other getters from AppLocalizations here if they were intentionally removed
// and are still needed, otherwise, this file is now synced with app_en.arb
// as per the generated AppLocalizations.

  // Form Validation Messages
  static String get enterPhoneNumber => _instance.enterPhoneNumber;

  static String get enterValidPhoneNumber => _instance.enterValidPhoneNumber;

  static String get enterCompletePhoneNumber =>
      _instance.enterCompletePhoneNumber;

  static String get enterEmail => _instance.enterEmail;

  static String get enterValidEmail => _instance.enterValidEmail;

  static String get enterPassword => _instance.enterPassword;

  static String get passwordTooShortMessage =>
      _instance.passwordTooShortMessage;

  static String get passwordTooLongMessage => _instance.passwordTooLongMessage;

  static String get confirmYourPassword => _instance.confirmYourPassword;

  static String get passwordsDoNotMatch => _instance.passwordsDoNotMatch;

  static String get enterName => _instance.enterName;

  static String get invalidNameFormat => _instance.invalidNameFormat;

  static String get nameTooShort => _instance.nameTooShort;

  static String get nameTooLong => _instance.nameTooLong;

  static String get enterText => _instance.enterText;

  static String get enterNumber => _instance.enterNumber;

  static String get enterValidNumber => _instance.enterValidNumber;

  static String get enterDate => _instance.enterDate;

  static String get enterValidDateFormat => _instance.enterValidDateFormat;

  static String get dateMustBeInPast => _instance.dateMustBeInPast;

  // Time/Date Related Messages
  static String get today => _instance.today;

  static String get yesterday => _instance.yesterday;

  // UI Component Labels
  static String get firstName => _instance.firstName;

  static String get lastName => _instance.lastName;

  static String get dateOfBirth => _instance.dateOfBirth;

  static String get viewAll => _instance.viewAll;

  // Profile Setup Strings
  static String get profileSetupDetailsTitle =>
      _instance.profileSetupDetailsTitle;

  static String get profileSetupDetailsSubtitle =>
      _instance.profileSetupDetailsSubtitle;

  static String get profileSetupGenderTitle =>
      _instance.profileSetupGenderTitle;

  static String get profileSetupGenderSubtitle =>
      _instance.profileSetupGenderSubtitle;

  static String get profileSetupInterestsTitle =>
      _instance.profileSetupInterestsTitle;

  static String get profileSetupInterestsSubtitle =>
      _instance.profileSetupInterestsSubtitle;

  static String get unexpectedStepIndex => _instance.unexpectedStepIndex;

  static String get onboardingCompleted => _instance.onboardingCompleted;

  static String get failedToLoadSports => _instance.failedToLoadSports;

  static String get male => _instance.male;

  static String get female => _instance.female;

  static String howDoYouRateYourselfIn(String sportName) =>
      _instance.howDoYouRateYourselfIn(sportName);

  static String get thisHelpsUsFindAndConnectYouToRelevantPeople =>
      _instance.thisHelpsUsFindAndConnectYouToRelevantPeople;

  // Number Range Messages
  static String numberMustBeGreaterThan(int min) =>
      _instance.numberMustBeGreaterThan(min);

  static String numberMustBeLessThan(int max) =>
      _instance.numberMustBeLessThan(max);

  static String get or => _instance.or;
}
