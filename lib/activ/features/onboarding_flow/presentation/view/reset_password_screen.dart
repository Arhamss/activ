import 'package:activ/activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/exports.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:activ/utils/widgets/core_widgets/dialog.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<OnboardingFlowCubit, OnboardingFlowState>(
        listenWhen: (previous, current) =>
            previous.resetPassword.status != current.resetPassword.status,
        listener: (context, state) {
          if (state.resetPassword.isFailure) {
            ToastHelper.showErrorToast(
              state.resetPassword.errorMessage ?? Localization.failedToResetPassword,
            );
          } else if (state.resetPassword.isLoaded) {
            CustomDialog.showActionDialog(
              svgAssetPath: AssetPaths.checkMark,
              context: context,
              title: Localization.passwordResetSuccessTitle,
              message:
                  Localization.passwordResetSuccessMessage,
              confirmText:Localization.signIn,
              onConfirm: () {
                context.pop();
                context.read<OnboardingFlowCubit>().resetResetPassword();
                context.goNamed(AppRouteNames.signInScreen);
              },
            );
          } else if (state.resetPassword.isFailure) {
            ToastHelper.showErrorToast(
              state.resetPassword.errorMessage ?? Localization.failedToResetPassword,
            );
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  maxWidth: constraints.maxWidth,
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SvgPicture.asset(AssetPaths.smallLogo),
                          const SizedBox(height: 48),
                          Text(
                            Localization.resetPassword,
                            style: context.h1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 32,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 48),
                          ActivTextField(
                            borderRadius: 16,
                            type: ActivTextFieldType.password,
                            prefixPath: AssetPaths.passwordLogo,
                            hintText: Localization.newPassword,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Localization.passwordRequired;
                              }
                              if (value.length < 6) {
                                return Localization.passwordTooShort;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ActivTextField(
                            borderRadius: 16,
                            type: ActivTextFieldType.password,
                            prefixPath: AssetPaths.passwordLogo,
                            hintText: Localization.confirmPassword,
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return Localization.passwordMismatch;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 200,
        ),
        child: BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
          builder: (context, state) {
            return ActivButton(
              borderRadius: 15,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<OnboardingFlowCubit>().resetPassword(
                        state.resetCode ?? '',
                        _passwordController.text.trim(),
                      );
                }
              },
              text: Localization.resetPassword,
              isLoading: state.resetPassword.isLoading,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
