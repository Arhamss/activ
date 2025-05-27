import 'package:activ/core/app_preferences/app_preferences.dart';
import 'package:activ/core/di/injector.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<OnboardingFlowCubit>().checkOnboardingStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingFlowCubit, OnboardingFlowState>(
      listener: (context, state) {
        if (Injector.resolve<AppPreferences>().getUserId() == null &&
            state.onboarded.isLoaded) {
          context.goNamed(AppRouteNames.introScreen);
        } else {
          if (state.onboarded.isLoaded && state.onboarded.data == true) {
            context.goNamed(AppRouteNames.homeScreen);
          } else {
            context.goNamed(AppRouteNames.profileSetupScreen);
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetPaths.activLogo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
