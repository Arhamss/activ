import 'package:activ/exports.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  static String get orCreateA => _instance.orCreateA;
  static String get newAccount => _instance.newAccount;
  static String get signInToContinue => _instance.signInToContinue;
  static String get signUpToContinue => _instance.signUpToContinue;
  static String get continieWithApple => _instance.continueWithApple;
  static String get continueWithGoogle => _instance.continueWithGoogle;
  static String get passwordResetSuccessTitle =>
      _instance.passwordResetSuccessTitle;
  static String get passwordResetSuccessMessage =>
      _instance.passwordResetSuccessMessage;
  static String get linkSentToEmail => _instance.linkSentToEmail;
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
  static String get byContinuingYouAgreeToOur => _instance.byContinuingYouAgreeToOur;
  static String get termsOfService => _instance.termsOfServiceLink;

  // --- End of General App Strings ---

  // Add other getters from AppLocalizations here if they were intentionally removed
  // and are still needed, otherwise, this file is now synced with app_en.arb
  // as per the generated AppLocalizations.
}
