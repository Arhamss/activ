import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/gender%20widget.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:flutter/material.dart';

class DetailsStep2Screen extends StatelessWidget {
  DetailsStep2Screen(this.constraints, {super.key});

  final BoxConstraints constraints;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Allow the column to shrink-wrap its children
            children: [
              SizedBox(height: constraints.maxHeight * 0.2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GenderOptionWidget(
                    svgAsset: AssetPaths.maleSVG,
                    title: 'Male',
                    isSelected: state.gender == 'male',
                    onTap: () =>
                        context.read<OnboardingFlowCubit>().setGender('male'),
                  ),
                  const SizedBox(width: 16),
                  GenderOptionWidget(
                    svgAsset: AssetPaths.femaleSVG,
                    title: 'Female',
                    isSelected: state.gender == 'female',
                    onTap: () =>
                        context.read<OnboardingFlowCubit>().setGender('female'),
                  ),
                ],
              ),
              SizedBox(height: constraints.maxHeight * 0.25),
              SafeArea(
                child: ActivButton(
                  disabled: state.gender.isEmpty,
                  text: Localization.continueText,
                  onPressed: () {
                    context.read<OnboardingFlowCubit>().setDetailsIndex(
                          state.detailsIndex + 1,
                        );
                  },
                  isLoading: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
