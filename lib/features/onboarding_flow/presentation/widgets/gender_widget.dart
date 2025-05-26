import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/gender_card.dart';

class GenderWidget extends StatelessWidget {
  GenderWidget(this.constraints, {super.key});

  final BoxConstraints constraints;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: constraints.maxHeight * 0.2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GenderCard(
                    svgAsset: AssetPaths.maleSVG,
                    title: 'Male',
                    isSelected: state.gender == 'male',
                    onTap: () =>
                        context.read<OnboardingFlowCubit>().setGender('male'),
                  ),
                  const SizedBox(width: 16),
                  GenderCard(
                    svgAsset: AssetPaths.femaleSVG,
                    title: 'Female',
                    isSelected: state.gender == 'female',
                    onTap: () =>
                        context.read<OnboardingFlowCubit>().setGender('female'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
