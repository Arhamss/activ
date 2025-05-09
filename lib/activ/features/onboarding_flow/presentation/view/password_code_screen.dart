

import 'package:activ/activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:activ/constants/asset_paths.dart';
import 'package:activ/exports.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
      appBar: AppBar(
        backgroundColor: AppColors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Image.asset(AssetPaths.logo, height: 160),
                  SizedBox(height: constraints.maxHeight * 0.08),
                  Text(
                    'Verification Code',
                    style: context.h1.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter the verification code, sent on the email you entered.',
                    style: context.b2.copyWith(
                      color: AppColors.greyShade2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ActivTextField(
                    hintText: 'Code',
                    labelText: 'Code',
                    controller: _codeController,
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
                    builder: (context, state) {
                      return ActivButton(
                        textColor: AppColors.white,
                        borderRadius: 15,
                        backgroundColor: AppColors.primaryBlue,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // await context
                            //     .read<OnboardingFlowCubit>()
                            //     .setResetCode(
                            //       _codeController.text,
                            //     );

                            context.goNamed(AppRouteNames.resetPasswordScreen);
                          } else {
                            ToastHelper.showInfoToast(
                              'Please enter a valid code',
                            );
                          }
                        },
                        text: 'Change Password',
                        isLoading: false,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
