import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/exports.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/helpers/focus_handler.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:pinput/pinput.dart';

class PasswordCode extends StatefulWidget {
  const PasswordCode({super.key});

  @override
  State<PasswordCode> createState() => _PasswordCodeState();
}

class _PasswordCodeState extends State<PasswordCode> {
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return FocusHandler(
            child: Container(
              padding: const EdgeInsets.all(24),
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxWidth: constraints.maxWidth,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Center(
                      child: SvgPicture.asset(AssetPaths.smallLogo),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Text(
                      textAlign: TextAlign.center,
                      Localization.enterResetCode,
                      style: context.h3.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Pinput(
                      controller: _codeController,
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: context.b1.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.greyShade6),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: context.b1.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Localization.pleaseEnterResetCode;
                        }
                        if (value.length < 6) {
                          return Localization.passwordTooShort;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<OnboardingFlowCubit>().setPinCodeEntered(
                              value.length == 6,
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
            builder: (context, state) {
              return ActivButton(
                disabled: !state.pinCodeEntered,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<OnboardingFlowCubit>().setResetCode(
                          _codeController.text.trim(),
                        );
                    ToastHelper.showSuccessToast(
                      Localization.resetCodeSet,
                    );

                    context.pushNamed(AppRouteNames.resetPasswordScreen);
                  }
                },
                text: Localization.continueText,
                isLoading: state.forgotPassword.isLoading,
              );
            },
          ),
        ),
      ),
    );
  }
}
