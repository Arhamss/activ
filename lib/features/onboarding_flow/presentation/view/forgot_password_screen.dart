import 'package:activ/core/field_validators.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart'
    show OnboardingFlowState;
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/helpers/focus_handler.dart';
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
    return FocusHandler(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.black),
            onPressed: () => context.pop(),
          ),
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
                message: Localization.codeSentToEmail,
                confirmText: Localization.continueText,
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Center(
                        child: SvgPicture.asset(AssetPaths.smallLogo),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Text(
                        Localization.forgotPassword,
                        style: context.h3.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 32,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        Localization.forgotPasswordSubtitle,
                        style: context.b2.copyWith(),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      ActivTextField(
                        contentPadding:
                            const EdgeInsets.fromLTRB(12, 16, 0, 16),
                        prefixPath: AssetPaths.emailLogo,
                        type: ActivTextFieldType.email,
                        hintText: 'Email',
                        borderRadius: 12,
                        controller: _emailController,
                        validator: FieldValidators.emailValidator,
                      ),
                    ],
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
                      context.read<OnboardingFlowCubit>().forgotPassword(
                            _emailController.text.trim(),
                          );
                    }
                  },
                  text: Localization.verify,
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
