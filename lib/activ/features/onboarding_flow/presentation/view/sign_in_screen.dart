import 'package:activ/activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/activ/features/onboarding_flow/presentation/widgets/social_button.dart';
import 'package:activ/core/app_preferences/app_preferences.dart';
import 'package:activ/core/di/injector.dart';
import 'package:activ/exports.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:flutter/services.dart';

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          forceMaterialTransparency: true,
        ),
        body: BlocListener<OnboardingFlowCubit, OnboardingFlowState>(
          listener: (context, state) {
            if (state.signIn.isFailure
                // state.signInWithApple.isFailure ||
                // state.signInWithGoogle.isFailure
                ) {
              ToastHelper.showInfoToast(
                state.signIn.errorMessage ?? 'Failed to sign in user',
              );
            } else if (state.signIn.isLoaded
                // state.signInWithApple.isLoaded ||
                // state.signInWithGoogle.isLoaded
                ) {
              // context.goNamed(AppRouteNames.homeScreen);
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  24,
                  0,
                  24,
                  MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          SvgPicture.asset(AssetPaths.smallLogo),
                          const SizedBox(height: 32),
                          Text(
                            textAlign: TextAlign.start,
                            'Sign in to continue & join the action!',
                            style: context.h3.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 32,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('or create a ', style: context.b2),
                              GestureDetector(
                                onTap: () =>
                                    context.goNamed(AppRouteNames.signUpScreen),
                                child: Text(
                                  'new account',
                                  style: context.b2.copyWith(
                                    color: AppColors.secondaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          ActivTextField(
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 16, 0, 16),
                            prefixPath: AssetPaths.emailLogo,
                            type: ActivTextFieldType.email,
                            hintText: 'Email',
                            borderRadius: 12,
                            controller: emailController,
                          ),
                          const SizedBox(height: 16),
                          ActivTextField(
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 16, 0, 16),
                            prefixPath: AssetPaths.passwordLogo,
                            type: ActivTextFieldType.password,
                            hintText: 'Password',
                            borderRadius: 12,
                            controller: passwordController,
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => context
                                .pushNamed(AppRouteNames.forgotPasswordScreen),
                            child: Text(
                              'Forgot Password?',
                              style: context.b2.copyWith(
                                color: AppColors.secondaryBlue,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
                            builder: (context, state) {
                              return ActivButton(
                                borderRadius: 16,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // context.read<OnboardingFlowCubit>().signIn(
                                    //       emailController.text.trim(),
                                    //       passwordController.text.trim(),
                                    //     );
                                  }
                                },
                                text: 'Sign in',
                                isLoading: state.signIn.isLoading,
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'OR',
                            style: context.b2.copyWith(
                              color: AppColors.greyShade3,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
                            builder: (context, state) {
                              return SocialButton(
                                onPressed: () {
                                  // context
                                  //     .read<OnboardingFlowCubit>()
                                  //     .signInWithGoogle();
                                },
                                text: 'Connect with Google',
                                svgPath: AssetPaths.googleIcon,
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
                            builder: (context, state) {
                              return SocialButton(
                                onPressed: () {
                                  // context
                                  //     .read<OnboardingFlowCubit>()
                                  //     .signInWithApple();
                                },
                                text: 'Connect with Apple',
                                svgPath: AssetPaths.appleIcon,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
