import 'package:activ/core/app_preferences/app_preferences.dart';
import 'package:activ/core/di/injector.dart';
import 'package:activ/core/field_validators.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/social_button.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/helpers/toast_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final cache = Injector.resolve<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocListener<OnboardingFlowCubit, OnboardingFlowState>(
            listener: (context, state) {
              if (state.signIn.isFailure ||
                  state.signInWithApple.isFailure ||
                  state.signInWithGoogle.isFailure) {
                ToastHelper.showInfoToast(
                  state.signIn.errorMessage ?? Localization.failedToSignInUser,
                );
                context.read<OnboardingFlowCubit>().resetAllSignIn();
              } else if (state.signIn.isLoaded ||
                  state.signInWithApple.isLoaded ||
                  state.signInWithGoogle.isLoaded) {
                context.goNamed(AppRouteNames.profileSetupScreen);
                ToastHelper.showInfoToast(
                  Localization.signInSuccess,
                );

                context.read<OnboardingFlowCubit>().resetAllSignIn();
              }
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.05),
                        SvgPicture.asset(AssetPaths.smallLogo),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        Text(
                          textAlign: TextAlign.center,
                          Localization.signInToContinue,
                          style: context.h3.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        ActivTextField(
                          prefixPath: AssetPaths.emailLogo,
                          type: ActivTextFieldType.email,
                          hintText: Localization.email,
                          borderRadius: 12,
                          controller: emailController,
                          validator: FieldValidators.emailValidator,
                        ),
                        const SizedBox(height: 16),
                        ActivTextField(
                          prefixPath: AssetPaths.passwordLogo,
                          type: ActivTextFieldType.password,
                          hintText: Localization.password,
                          borderRadius: 12,
                          controller: passwordController,
                          validator: FieldValidators.passwordValidator,
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => context.pushNamed(
                            AppRouteNames.forgotPasswordScreen,
                          ),
                          child: Text(
                            Localization.forgotPassword,
                            style: context.b2.copyWith(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
                          builder: (context, state) {
                            return ActivButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<OnboardingFlowCubit>().signIn(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                }
                              },
                              text: Localization.signIn,
                              isLoading: state.signIn.isLoading,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: AppColors.greyShade6,
                                thickness: 1.04,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                Localization.orConnectWith,
                                style: context.b2.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: AppColors.greyShade6,
                                thickness: 1.04,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
                          builder: (context, state) {
                            return SocialButton(
                              onPressed: () {
                                context
                                    .read<OnboardingFlowCubit>()
                                    .signInWithGoogle();
                              },
                              text: Localization.continueWithGoogle,
                              svgPath: AssetPaths.googleIcon,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
                          builder: (context, state) {
                            return SocialButton(
                              onPressed: () {
                                context
                                    .read<OnboardingFlowCubit>()
                                    .signInWithApple();
                              },
                              text: Localization.continieWithApple,
                              svgPath: AssetPaths.appleIcon,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Localization.dontHaveAnAccount,
                              style: context.b2.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  context.goNamed(AppRouteNames.signUpScreen),
                              child: Text(
                                Localization.createANewOne,
                                style: context.b2.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
