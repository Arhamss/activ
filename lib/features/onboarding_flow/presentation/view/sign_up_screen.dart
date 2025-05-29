import 'package:activ/core/field_validators.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/social_button.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/helpers/toast_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<OnboardingFlowCubit>().resetSignUp();
    context.read<OnboardingFlowCubit>().resetAllSignIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocListener<OnboardingFlowCubit, OnboardingFlowState>(
            listener: (context, state) {
              if (state.signUp.isFailure) {
                ToastHelper.showErrorToast(
                  state.signUp.errorMessage ?? Localization.failedToSignUpUser,
                );
                context.read<OnboardingFlowCubit>().resetSignUp();
                context.read<OnboardingFlowCubit>().resetAllSignIn();
              } else if (state.signUp.isLoaded) {
                context.goNamed(AppRouteNames.profileSetupScreen);
              } else if (state.signInWithGoogle.isLoaded) {
                context.goNamed(AppRouteNames.profileSetupScreen);
              } else if (state.signInWithGoogle.isFailure) {
                ToastHelper.showErrorToast(
                  state.signInWithGoogle.errorMessage ??
                      Localization.failedToSignInWithGoogle,
                );
                context.read<OnboardingFlowCubit>().resetAllSignIn();
                context.read<OnboardingFlowCubit>().resetSignUp();
              } else if (state.signInWithApple.isLoaded) {
                context.goNamed(AppRouteNames.profileSetupScreen);
              } else if (state.signInWithApple.isFailure) {
                ToastHelper.showErrorToast(
                  state.signInWithApple.errorMessage ??
                      Localization.failedToSignInUser,
                );
                context.read<OnboardingFlowCubit>().resetAllSignIn();
                context.read<OnboardingFlowCubit>().resetSignUp();
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
                          Localization.signUpToContinue,
                          style: context.h3.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ActivTextField(
                          prefixPath: AssetPaths.emailLogo,
                          type: ActivTextFieldType.email,
                          hintText: Localization.email,
                          controller: emailController,
                          validator: FieldValidators.emailValidator,
                        ),
                        const SizedBox(height: 16),
                        ActivTextField(
                          prefixPath: AssetPaths.passwordLogo,
                          type: ActivTextFieldType.password,
                          hintText: Localization.password,
                          controller: passwordController,
                          validator: FieldValidators.passwordValidator,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
                          builder: (context, state) {
                            return ActivButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<OnboardingFlowCubit>().signUp(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                }
                              },
                              text: Localization.nextText,
                              isLoading: state.signUp.isLoading,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: AppColors.greyShade6,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                Localization.or,
                                style: context.b2.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: AppColors.greyShade6,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
                          builder: (context, state) {
                            return SocialButton(
                              onPressed: () async {
                                await context
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
                              onPressed: () async {
                                await context
                                    .read<OnboardingFlowCubit>()
                                    .signInWithApple();
                              },
                              text: Localization.continieWithApple,
                              svgPath: AssetPaths.appleIcon,
                            );
                          },
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: Localization.byContinuingYouAgreeToOur,
                            style: context.b2.copyWith(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: Localization.termsOfService,
                                style: context.b2.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${Localization.alreadyHaveAccount} ',
                              style: context.b2.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  context.goNamed(AppRouteNames.signInScreen),
                              child: Text(
                                Localization.signIn,
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
