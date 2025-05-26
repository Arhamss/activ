import 'package:activ/constants/constants.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/interest_widget.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/sports_rating_dialog.dart';

extension StringExtension on String {
  String get capitalizeFirstOfEach => replaceAll('_', ' ')
      .split(' ')
      .map(
        (str) =>
            str.isNotEmpty ? '${str[0].toUpperCase()}${str.substring(1)}' : '',
      )
      .join(' ');
}

class SportsSelectionWidget extends StatelessWidget {
  SportsSelectionWidget(this.constraints, {super.key});

  final BoxConstraints constraints;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
      builder: (context, state) {
        return Column(
          children: [
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 32,
              runSpacing: 16,
              children: AppConstants.interestAssets.map((asset) {
                final isSelected = state.selectedInterests.containsKey(asset);
                return InterestWidget(
                  svgPath: asset,
                  subtitle: asset
                      .split('/')
                      .last
                      .split('.')
                      .first
                      .capitalizeFirstOfEach,
                  isSelected: isSelected,
                  onTap: () {
                    if (state.selectedInterests.containsKey(asset)) {
                      // If already selected, remove it
                      context.read<OnboardingFlowCubit>().removeInterest(asset);
                      return;
                    }
                    showDialog<int>(
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
                      return;
                    }

                    context
                        .read<OnboardingFlowCubit>()
                        .addInterest(asset, rating.toInt());

                    context.read<SportsDialogCubit>().resetRating();
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}
