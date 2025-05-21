import 'package:activ/activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/activ/features/onboarding_flow/presentation/cubit/state.dart'
    show OnboardingFlowState;
import 'package:activ/exports.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:activ/utils/widgets/core_widgets/dialog.dart';
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
                    Localization.failedToSendPasswordRecovery,
              );
            } else if (state.forgotPassword.isLoaded) {
              CustomDialog.showActionDialog(
                svgAssetPath: AssetPaths.checkMark,
                context: context,
                title: Localization.success,
                message: Localization.linkSentToEmail,
                confirmText: Localization.submit,
                onConfirm: () {
                  context.pop();
                  context.read<OnboardingFlowCubit>().resetForgotPassword();
                  context.pushNamed(AppRouteNames.resetPasswordCodeScreen);
                },
              );
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
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
                        children: [
                          const SizedBox(height: 32),
                          Center(
                            child: SvgPicture.asset(AssetPaths.smallLogo),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            Localization.forgotPassword,
                            style: context.h3.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 32,
                            ),
                            textAlign: TextAlign.center,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Localization.emailRequired;
                              }
                              if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              ).hasMatch(value)) {
                                return Localization.invalidEmail;
                              }
                              return null;
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
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
              builder: (context, state) {
                return ActivButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // context
                      //     .read<OnboardingFlowCubit>()
                      //     .forgotPassword(
                      //       _emailController.text.trim(),
                      //     );

                      context.read<OnboardingFlowCubit>().forgotPassword(
                            _emailController.text.trim(),
                          );
                    }
                  },
                  text: Localization.continueText,
                  isLoading: state.forgotPassword.isLoading,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
