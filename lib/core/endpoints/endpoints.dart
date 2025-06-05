import 'package:activ/config/api_environment.dart';

class Endpoints {
  Endpoints._();
  static String get baseUrl => ApiEnvironment.current.baseUrl;
  static String get apiVersion => ApiEnvironment.current.apiVersion;

  /// Authentication Endpoints
  static const String login = 'auth/login';
  static const String signup = 'auth/signup';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';
  static const String changePassword = 'auth/change-password';
  static const String profile = 'auth/profile';
  static const String deleteAccount = 'auth/delete-account';
  static const String signinWithGoogle = 'auth/google-signin';
  static const String signinWithApple = 'auth/apple-signin';
  static const String getAllSports = 'sports';
  static const String onboarded = 'user/me/onboarded';
  static const String completeOnboarding = 'user/me/onboarding';

  /// Home Endpoints
  static const String getUser = 'user/me';

  // Games Endpoints
  static const String addGame = 'game/create-game';
  static const String getUpcomingGames = 'game/upcoming';

  // Chat Endpoints
  static const String getChats = 'chat/user-channels';
  static const String getStreamChatAuth = 'chat/token';
}
