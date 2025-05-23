import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
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
          child: SizedBox(
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetPaths.maleSvg,
                    ),
                    const SizedBox(width: 16), // Add spacing between the fields
                    SvgPicture.asset(
                      AssetPaths.femaleSvg,
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.2),
                ActivButton(
                  text: Localization.continueText,
                  onPressed: () {
                    context.read<OnboardingFlowCubit>().setDetailsIndex(
                          state.detailsIndex + 1,
                        );
                  },
                  isLoading: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
