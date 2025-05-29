import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/interest_widget.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/sports_rating_dialog.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/widgets/core_widgets/retry_widget.dart';

class SportsSelectionWidget extends StatefulWidget {
  const SportsSelectionWidget(this.constraints, {super.key});

  final BoxConstraints constraints;

  @override
  State<SportsSelectionWidget> createState() => _SportsSelectionWidgetState();
}

class _SportsSelectionWidgetState extends State<SportsSelectionWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<OnboardingFlowCubit>().getAllSports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
      builder: (context, state) {
        if (state.sports.isLoading) {
          return const LoadingWidget();
        }

        if (state.sports.isFailure) {
          return RetryWidget(
            message:
                state.sports.errorMessage ?? Localization.failedToLoadSports,
            onRetry: () {
              context.read<OnboardingFlowCubit>().getAllSports();
            },
          );
        }

        return Column(
          children: [
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 32,
              runSpacing: 16,
              children: state.sports.data?.map((sport) {
                    final isSelected =
                        state.selectedInterests.containsKey(sport.id);
                    return InterestWidget(
                      svgPath: sport.illustrationUrl,
                      subtitle: sport.name,
                      isSelected: isSelected,
                      onTap: () async {
                        if (state.selectedInterests.containsKey(sport.id)) {
                          context
                              .read<OnboardingFlowCubit>()
                              .removeInterest(sport.id);
                          return;
                        }
                        final rating = await showDialog<double>(
                          context: context,
                          builder: (context) => SportRatingDialog(
                            sportName: sport.name,
                          ),
                        );

                        if ((rating ?? 0) == 0) return;

                        context
                            .read<OnboardingFlowCubit>()
                            .addInterest(sport.id, rating!.toDouble());
                      },
                    );
                  }).toList() ??
                  [],
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}
