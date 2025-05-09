import 'package:activ/activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/activ/features/onboarding_flow/presentation/widgets/social_button.dart';
import 'package:activ/exports.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:flutter/services.dart';

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          forceMaterialTransparency: true,
        ),
        body: SafeArea(
          child: BlocListener<OnboardingFlowCubit, OnboardingFlowState>(
            listener: (context, state) {
              if (state.signUp.isFailure) {
                ToastHelper.showInfoToast(
                  state.signUp.errorMessage ?? 'Failed to sign in user',
                );
              } else if (state.signInWithGoogle.isLoaded) {
                ToastHelper.showInfoToast(
                  'Successfully signed in with Google',
                );
                //context.goNamed(AppRouteNames.selectLocation);
              } else if (state.signInWithGoogle.isFailure) {
                ToastHelper.showInfoToast(
                  state.signInWithGoogle.errorMessage ??
                      'Failed to sign in with Google',
                );
              } else if (state.signUp.isLoaded) {
                //context.goNamed(AppRouteNames.selectLocation);
              }
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    24,
                    0, // Change from 24 to 0 to match sign-in
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
                            const SizedBox(height: 32), // Add this line
                            SvgPicture.asset(AssetPaths.smallLogo),
                            const SizedBox(height: 32),
                            Text(
                              'Sign Up to continue and stay activ',
                              style: context.h3.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 32,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account? ',
                                  style: context.b2.copyWith(),
                                ),
                                GestureDetector(
                                  onTap: () => context
                                      .goNamed(AppRouteNames.signInScreen),
                                  child: Text(
                                    'Sign in',
                                    style: context.b2.copyWith(
                                      color: AppColors
                                          .secondaryColor, // Change from primaryBlue to match sign-in
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            const SizedBox(height: 16),
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
                            const SizedBox(height: 32),
                            BlocBuilder<OnboardingFlowCubit,
                                OnboardingFlowState>(
                              builder: (context, state) {
                                return ActivButton(
                                  borderRadius: 16,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // context
                                      //     .read<OnboardingFlowCubit>()
                                      //     .signUp(
                                      //       nameController.text.trim(),
                                      //       emailController.text
                                      //           .trim()
                                      //           .toLowerCase(),
                                      //       passwordController.text.trim(),
                                      //     );
                                    } else {
                                      ToastHelper.showInfoToast(
                                        'Please fill in all fields',
                                      );
                                    }
                                  },
                                  text: 'Next',
                                  isLoading: state.signUp.isLoading,
                                );
                              },
                            ),
                            const SizedBox(height: 16), // Change from 32
                            Text(
                              'OR',
                              style: context.b2.copyWith(
                                color: AppColors.greyShade2,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16), // Change from 32
                            BlocBuilder<OnboardingFlowCubit,
                                OnboardingFlowState>(
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
                            BlocBuilder<OnboardingFlowCubit,
                                OnboardingFlowState>(
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
                            const SizedBox(height: 32),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'By continuing you agree to our ',
                                style: context.b2.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: context.b2.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
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
      ),
    );
  }
}
