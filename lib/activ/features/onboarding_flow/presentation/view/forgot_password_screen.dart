import 'package:activ/activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/activ/features/onboarding_flow/presentation/cubit/state.dart'
    show OnboardingFlowState;
import 'package:activ/exports.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
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
            if (state.forgotPassword.isFailure) {
              ToastHelper.showErrorToast(
                state.forgotPassword.errorMessage ??
                    'Failed to send password recovery email',
              );
            } else if (state.forgotPassword.isLoaded) {
              context.goNamed(AppRouteNames.resetPasswordCodeScreen);
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: constraints.maxWidth,
                  ),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          Center(
                            child: SvgPicture.asset(AssetPaths.smallLogo),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Forgot Password',
                            style: context.h3.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 32,
                            ),
                          ),
                          const SizedBox(height: 30),
                          ActivTextField(
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 16, 0, 16),
                            prefixPath: AssetPaths.emailLogo,
                            type: ActivTextFieldType.email,
                            hintText: 'Email',
                            borderRadius: 12,
                            controller: _emailController,
                          ),
                          const SizedBox(height: 40),
                          BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
                            builder: (context, state) {
                              return ActivButton(
                                borderRadius: 16,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // context
                                    //     .read<OnboardingFlowCubit>()
                                    //     .forgotPassword(
                                    //       _emailController.text.trim(),
                                    //     );

                                    ToastHelper.showSuccessToast(
                                      'Form Validated',
                                    );
                                  }
                                },
                                text: 'Continue',
                                isLoading: state.forgotPassword.isLoading,
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
