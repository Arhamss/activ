import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Activ'**
  String get appName;

  /// No description provided for @intro1Title.
  ///
  /// In en, this message translates to:
  /// **'Explore City and Nearby Sport Clubs'**
  String get intro1Title;

  /// No description provided for @intro1Description.
  ///
  /// In en, this message translates to:
  /// **'Discover sports clubs and facilities around you to join games, train, and stay active.'**
  String get intro1Description;

  /// No description provided for @intro2Title.
  ///
  /// In en, this message translates to:
  /// **'Choose your sport and Explore Club'**
  String get intro2Title;

  /// No description provided for @intro2Description.
  ///
  /// In en, this message translates to:
  /// **'Pick your favorite sport and find the best clubs to play and connect.'**
  String get intro2Description;

  /// No description provided for @intro3Title.
  ///
  /// In en, this message translates to:
  /// **'Select Slot and make a Reservation'**
  String get intro3Title;

  /// No description provided for @intro3Description.
  ///
  /// In en, this message translates to:
  /// **'Pick your preferred time and book your place with ease.'**
  String get intro3Description;

  /// No description provided for @skipText.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipText;

  /// No description provided for @nextText.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextText;

  /// No description provided for @getStartedText.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStartedText;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @enterResetCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Reset Code'**
  String get enterResetCode;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @orConnectWith.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get orConnectWith;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get dontHaveAccount;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is Required'**
  String get passwordRequired;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is Required'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get success;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get oops;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get pleaseWait;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @timeoutError.
  ///
  /// In en, this message translates to:
  /// **'The request timed out'**
  String get timeoutError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get unknownError;

  /// No description provided for @featureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Feature coming soon'**
  String get featureComingSoon;

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello, World!'**
  String get helloWorld;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAnAccount;

  /// No description provided for @createANewOne.
  ///
  /// In en, this message translates to:
  /// **'Create a new one'**
  String get createANewOne;

  /// No description provided for @newAccount.
  ///
  /// In en, this message translates to:
  /// **'New account'**
  String get newAccount;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry — it happens to the best of us. Let\'s reset your password.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue & join the action!'**
  String get signInToContinue;

  /// No description provided for @signUpToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign Up to continue and stay activ'**
  String get signUpToContinue;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @passwordResetSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Reset Success!'**
  String get passwordResetSuccessTitle;

  /// No description provided for @passwordResetSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'You now have full access to your account, welcome back.'**
  String get passwordResetSuccessMessage;

  /// No description provided for @codeSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a six-digit code to your email in order to verify your identity.'**
  String get codeSentToEmail;

  /// No description provided for @failedToSendPasswordRecovery.
  ///
  /// In en, this message translates to:
  /// **'Failed to send password recovery email'**
  String get failedToSendPasswordRecovery;

  /// No description provided for @failedToResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset password'**
  String get failedToResetPassword;

  /// No description provided for @failedToSignInUser.
  ///
  /// In en, this message translates to:
  /// **'Failed to Sign In User'**
  String get failedToSignInUser;

  /// No description provided for @failedToSignUpUser.
  ///
  /// In en, this message translates to:
  /// **'Failed to Sign Up User'**
  String get failedToSignUpUser;

  /// No description provided for @successfullySignedInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Successfully signed in with Google'**
  String get successfullySignedInWithGoogle;

  /// No description provided for @failedToSignInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Failed to sign in with Google'**
  String get failedToSignInWithGoogle;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourName;

  /// No description provided for @resetCodeSet.
  ///
  /// In en, this message translates to:
  /// **'Reset code set'**
  String get resetCodeSet;

  /// No description provided for @codeMustBe6Digits.
  ///
  /// In en, this message translates to:
  /// **'Code must be 6 digits'**
  String get codeMustBe6Digits;

  /// No description provided for @pleaseEnterResetCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the reset code'**
  String get pleaseEnterResetCode;

  /// No description provided for @byContinuingYouAgreeToOur.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to our '**
  String get byContinuingYouAgreeToOur;

  /// No description provided for @termsOfServiceLink.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfServiceLink;

  /// No description provided for @resetCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6-digit code to your email. Please enter it below to verify your identity.'**
  String get resetCodeSubtitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password below to reset it.'**
  String get resetPasswordSubtitle;

  /// No description provided for @signInSuccess.
  ///
  /// In en, this message translates to:
  /// **'Signed In Successfully'**
  String get signInSuccess;

  /// No description provided for @failedToLoadSports.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Sports'**
  String get failedToLoadSports;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get enterPhoneNumber;

  /// No description provided for @enterValidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get enterValidPhoneNumber;

  /// No description provided for @enterCompletePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a complete phone number'**
  String get enterCompletePhoneNumber;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enterEmail;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get enterPassword;

  /// No description provided for @passwordTooShortMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password greater than 6 characters'**
  String get passwordTooShortMessage;

  /// No description provided for @passwordTooLongMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password less than 100 characters'**
  String get passwordTooLongMessage;

  /// No description provided for @confirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmYourPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter the name'**
  String get enterName;

  /// No description provided for @invalidNameFormat.
  ///
  /// In en, this message translates to:
  /// **'Name can only contain letters, spaces, hyphens, and apostrophes'**
  String get invalidNameFormat;

  /// No description provided for @nameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters long'**
  String get nameTooShort;

  /// No description provided for @nameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Name must be less than 30 characters'**
  String get nameTooLong;

  /// No description provided for @enterText.
  ///
  /// In en, this message translates to:
  /// **'Please enter the text'**
  String get enterText;

  /// No description provided for @enterNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a number'**
  String get enterNumber;

  /// No description provided for @enterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get enterValidNumber;

  /// Message shown when number is less than minimum
  ///
  /// In en, this message translates to:
  /// **'Number must be greater than or equal to {min}'**
  String numberMustBeGreaterThan(int min);

  /// Message shown when number exceeds maximum
  ///
  /// In en, this message translates to:
  /// **'Number must be less than or equal to {max}'**
  String numberMustBeLessThan(int max);

  /// No description provided for @enterDate.
  ///
  /// In en, this message translates to:
  /// **'Please enter a date'**
  String get enterDate;

  /// No description provided for @enterValidDateFormat.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid date in DD/MM/YYYY format'**
  String get enterValidDateFormat;

  /// No description provided for @dateMustBeInPast.
  ///
  /// In en, this message translates to:
  /// **'Date must be in the past'**
  String get dateMustBeInPast;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @profileSetupDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tell me some details please?'**
  String get profileSetupDetailsTitle;

  /// No description provided for @profileSetupDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please provide a few details to help your friend find your activ account'**
  String get profileSetupDetailsSubtitle;

  /// No description provided for @profileSetupGenderTitle.
  ///
  /// In en, this message translates to:
  /// **'What is your Gender?'**
  String get profileSetupGenderTitle;

  /// No description provided for @profileSetupGenderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This helps us find you more relevant content'**
  String get profileSetupGenderSubtitle;

  /// No description provided for @profileSetupInterestsTitle.
  ///
  /// In en, this message translates to:
  /// **'What are your interests?'**
  String get profileSetupInterestsTitle;

  /// No description provided for @profileSetupInterestsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select your interests to personalize your experience'**
  String get profileSetupInterestsSubtitle;

  /// No description provided for @unexpectedStepIndex.
  ///
  /// In en, this message translates to:
  /// **'Unexpected step index.'**
  String get unexpectedStepIndex;

  /// No description provided for @onboardingCompleted.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Completed!!'**
  String get onboardingCompleted;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Question asking user to rate their skill in a sport
  ///
  /// In en, this message translates to:
  /// **'How do you rate yourself in {sportName}?'**
  String howDoYouRateYourselfIn(String sportName);

  /// No description provided for @thisHelpsUsFindAndConnectYouToRelevantPeople.
  ///
  /// In en, this message translates to:
  /// **'This helps us find and connect you to relevant people'**
  String get thisHelpsUsFindAndConnectYouToRelevantPeople;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
