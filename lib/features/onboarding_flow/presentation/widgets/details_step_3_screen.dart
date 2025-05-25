import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/interest_widget.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/sports_rating_dialog.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String get capitalizeFirstOfEach => replaceAll('_', ' ')
      .split(' ')
      .map(
        (str) =>
            str.isNotEmpty ? '${str[0].toUpperCase()}${str.substring(1)}' : '',
      )
      .join(' ');
}

class DetailsStep3Screen extends StatelessWidget {
  DetailsStep3Screen(this.constraints, {super.key});

  final BoxConstraints constraints;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // List of interest-related assets
    final interestAssets = [
      AssetPaths.runningIcon,
      AssetPaths.cyclingIcon,
      AssetPaths.swimmingIcon,
      AssetPaths.bowlingIcon,
      AssetPaths.tennisIcon,
      AssetPaths.basketballIcon,
      AssetPaths.footballIcon,
      AssetPaths.volleyballIcon,
      AssetPaths.badmintonIcon,
      AssetPaths.tableTennisIcon,
      AssetPaths.golfIcon,
      AssetPaths.cricketIcon,
      AssetPaths.fitnessIcon,
      AssetPaths.handBallIcon,
      AssetPaths.martialArtsIcon,
      AssetPaths.padelIcon,
    ];

    return BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
      builder: (context, state) {
        return Column(
          children: [
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 32,
              runSpacing: 16,
              children: interestAssets.map((asset) {
                final isSelected = state.selectedInterests.containsKey(asset);
                return InterestWidget(
                  svgPath: asset,
                  subtitle: asset
                      .split('/')
                      .last
                      .split('.')
                      .first
                      .capitalizeFirstOfEach, // Extract name
                  isSelected: isSelected,
                  onTap: () async {
                    if (state.selectedInterests.containsKey(asset)) {
                      // If already selected, remove it
                      context.read<OnboardingFlowCubit>().removeInterest(asset);
                      return;
                    }
                    await showDialog<int>(
                      context: context,
                      builder: (context) => SportRatingDialog(
                        sportName: asset
                            .split('/')
                            .last
                            .split('.')
                            .first
                            .capitalizeFirstOfEach,
                      ),
                    );

                    final rating =
                        context.read<SportsDialogCubit>().state.selectedRating;

                    if (rating == 0) {
                      // If no rating was selected, do not add the interest
                      return;
                    }

                    context
                        .read<OnboardingFlowCubit>()
                        .addInterest(asset, rating);

                    context.read<SportsDialogCubit>().resetRating();
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            SafeArea(
              child: ActivButton(
                disabled: state.selectedInterests.isEmpty,
                text: 'Next', // Button text
                onPressed: () {
                  // Handle button press (e.g., navigate to the next step)
                  // context.read<OnboardingFlowCubit>().setDetailsIndex(
                  //       state.detailsIndex + 1,
                  //     );

                  ToastHelper.showSuccessToast('Onboarding Completed!!');
                },
                isLoading: false,
              ),
            ),
          ],
        );
      },
    );
  }
}
