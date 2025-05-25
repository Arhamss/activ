part of 'exports.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  factory AppRouter() => _instance;

  AppRouter._internal();

  static final AppRouter _instance = AppRouter._internal();

  static BuildContext? get appContext =>
      AppRouter.router.routerDelegate.navigatorKey.currentContext;

  static String getCurrentLocation() {
    if (appContext == null) {
      throw Exception(
        'AppRouter.appContext is null. Ensure the appContext is initialized.',
      );
    }

    final router = GoRouter.of(appContext!);
    final configuration = router.routerDelegate.currentConfiguration;

    final lastMatch = configuration.last;
    final matchList =
        lastMatch is ImperativeRouteMatch ? lastMatch.matches : configuration;

    final currentLocation = matchList.uri.toString();
    return currentLocation;
  }

  static bool isCurrentRoute(String routeName) {
    final current = getCurrentLocation();
    return current == routeName || current.startsWith('$routeName?');
  }

  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        name: AppRouteNames.splash,
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRouteNames.introScreen,
        path: AppRoutes.introScreen,
        builder: (context, state) => const IntroScreen(),
      ),
      GoRoute(
        name: AppRouteNames.signInScreen,
        path: AppRoutes.signInScreen,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        name: AppRouteNames.resetPasswordCodeScreen,
        path: AppRoutes.resetPasswordCodeScreen,
        builder: (context, state) => const PasswordCode(),
      ),
      GoRoute(
        name: AppRouteNames.resetPasswordScreen,
        path: AppRoutes.resetPasswordScreen,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        name: AppRouteNames.signUpScreen,
        path: AppRoutes.signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: AppRouteNames.forgotPasswordScreen,
        path: AppRoutes.forgotPasswordScreen,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        name: AppRouteNames.addDetailsScreen,
        path: AppRoutes.addDetailsScreen,
        builder: (context, state) => const AddDetailsScreen(),
      ),
    ],
  );
}
