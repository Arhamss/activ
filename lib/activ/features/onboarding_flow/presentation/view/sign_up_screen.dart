import 'package:activ/activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/activ/features/onboarding_flow/presentation/widgets/social_button.dart';
import 'package:activ/exports.dart';
import 'package:activ/l10n/l10n.dart';
import 'package:activ/l10n/localization_service.dart';
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
                  state.signUp.errorMessage ?? Localization.failedToSignUpUser,
                );
              } else if (state.signInWithGoogle.isLoaded) {
                ToastHelper.showInfoToast(
                  Localization.successfullySignedInWithGoogle,
                );
                //context.goNamed(AppRouteNames.selectLocation);
              } else if (state.signInWithGoogle.isFailure) {
                ToastHelper.showInfoToast(
                  state.signInWithGoogle.errorMessage ??
                      Localization.failedToSignInWithGoogle,
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
                              Localization.signUpToContinue,
                              style: context.h3.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 32,
                              ),
                              textAlign: TextAlign.start,
                            ),

                            const SizedBox(height: 16),
                            ActivTextField(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 16, 0, 16),
                              prefixPath: AssetPaths.emailLogo,
                              type: ActivTextFieldType.email,
                              hintText: Localization.email,
                              borderRadius: 12,
                              controller: emailController,
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return Localization.emailRequired;
                                } else if (!RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(p0)) {
                                  return Localization.invalidEmail;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            ActivTextField(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 16, 0, 16),
                              prefixPath: AssetPaths.passwordLogo,
                              type: ActivTextFieldType.password,
                              hintText: Localization.password,
                              borderRadius: 12,
                              controller: passwordController,
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return Localization.passwordRequired;
                                } else if (p0.length < 6) {
                                  return Localization.passwordTooShort;
                                }
                                return null;
                              },
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
                                    color: AppColors.greyShade7,
                                    thickness: 1.04,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    'OR',
                                    style: context.b2.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: AppColors.greyShade7,
                                    thickness: 1.04,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            BlocBuilder<OnboardingFlowCubit,
                                OnboardingFlowState>(
                              builder: (context, state) {
                                return SocialButton(
                                  onPressed: () {
                                    // context
                                    //     .read<OnboardingFlowCubit>()
                                    //     .signInWithGoogle();
                                  },
                                  text: Localization.continueWithGoogle,
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
                                  text: Localization.continieWithApple,
                                  svgPath: AssetPaths.appleIcon,
                                );
                              },
                            ),
                            const Spacer(),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: Localization.byContinuingYouAgreeToOur,
                                style: context.b2.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: Localization.termsOfService,
                                    style: context.b2.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
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
                                  Localization.alreadyHaveAccount,
                                  style: context.b2.copyWith(),
                                ),
                                GestureDetector(
                                  onTap: () => context
                                      .goNamed(AppRouteNames.signInScreen),
                                  child: Text(
                                    Localization.signIn,
                                    style: context.b2.copyWith(
                                      color: AppColors
                                          .secondaryColor, // Change from primaryBlue to match sign-in
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}
