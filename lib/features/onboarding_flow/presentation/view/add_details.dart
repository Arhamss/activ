import 'package:activ/constants/export.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/details_step_1_screen.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/details_step_2.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/details_step_screen.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/widgets/core_widgets/export.dart';
import 'package:flutter/material.dart';
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            final currentIndex =
                context.read<OnboardingFlowCubit>().state.detailsIndex;
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
              value:
                  (context.read<OnboardingFlowCubit>().state.detailsIndex + 1) /
                      _totalSteps,
              backgroundColor: AppColors.inactiveProgressBar,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.activeDetailsProgressBar,
              ),
              minHeight: 8, // Controls thickness directly
            ),
          ),
        ],
      ),
      body: _buildCurrentStepBody(),
      // bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildCurrentStepBody() {
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
          subtitle: 'This help us find you more relevant content',
          body: DetailsStep2Screen.new,
        );
      case 2:
        return StepScreen(
          title: 'Step 3',
          subtitle: 'Review your information',
          body: (constraints) => const Column(
            children: [
              Text('Review details here'),
              // Add your form fields or other content
            ],
          ),
        );
      default:
        return StepScreen(
          title: 'Step 1',
          subtitle: 'Add your personal details here',
          body: (constraints) => const Column(
            children: [
              Text('Form fields for personal details go here'),
              // Add your form fields or other content
            ],
          ),
        );
    }
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
