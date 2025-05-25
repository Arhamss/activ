import 'package:activ/constants/export.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/details_step_1_screen.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/details_step_2.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/details_step_3_screen.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/details_step_screen.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/widgets/core_widgets/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({super.key});

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  final int _totalSteps = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            final currentIndex =
                context.watch<OnboardingFlowCubit>().state.detailsIndex;
            if (currentIndex > 0) {
              context
                  .read<OnboardingFlowCubit>()
                  .setDetailsIndex(currentIndex - 1);
            } else {
              context.pop();
            }
          },
        ),
        actions: [
          Container(
            width: 87.32,
            height: 8.32,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: LinearProgressIndicator(
              value: (context.watch<OnboardingFlowCubit>().state.detailsIndex +
                      1) /
                  _totalSteps,
              backgroundColor: AppColors.inactiveProgressBar,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.activeDetailsProgressBar,
              ),
              minHeight: 8,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      ),
      body: _buildCurrentStepBody(),
      // bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildCurrentStepBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (context.watch<OnboardingFlowCubit>().state.detailsIndex) {
          case 0:
            return const StepScreen(
              title: 'Tell me some details please?',
              subtitle:
                  'Please provide a few details to help your friend find your activ account',
              body: DetailsStep1Screen.new,
            );
          case 1:
            return const StepScreen(
              title: 'What is your Gender?',
              subtitle: 'This helps us find you more relevant content',
              body: DetailsStep2Screen.new,
            );
          case 2:
            return const StepScreen(
              title: 'What are your interests?',
              subtitle: 'Select your interests to personalize your experience',
              body: DetailsStep3Screen.new,
            );
          default:
            return const StepScreen(
              title: 'Tell me some details please?',
              subtitle:
                  'Please provide a few details to help your friend find your activ account',
              body: DetailsStep1Screen.new,
            );
        }
      },
    );
  }

  Widget _buildBottomNavigation() {
    return BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ActivButton(
              text: Localization.nextText,
              onPressed: () {
                context.read<OnboardingFlowCubit>().setDetailsIndex(
                      state.detailsIndex + 1,
                    );
              },
              isLoading: false,
            ),
          ),
        );
      },
    );
  }
}

class StepNavigationButton extends StatelessWidget {
  const StepNavigationButton({
    required this.currentIndex,
    required this.totalSteps,
    super.key,
  });

  final int currentIndex;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final isLastStep = currentIndex == totalSteps - 1;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ActivButton(
          disabled: currentIndex == 0 ? true : false,
          text: Localization.continueText,
          onPressed: () {
            if (isLastStep) {
              // Handle finish action
              //context.read<OnboardingFlowCubit>().completeOnboarding();
            } else if (currentIndex == 0) {
              context.read<OnboardingFlowCubit>().setDetailsIndex(
                    currentIndex + 1,
                  );
            }
          },
          isLoading: false,
        ),
      ),
    );
  }
}
