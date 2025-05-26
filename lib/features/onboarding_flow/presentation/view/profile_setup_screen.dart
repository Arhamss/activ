import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/StepWidget.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/gender_widget.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/sports_selection_widget.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/user_details_widget.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:flutter/services.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final int _totalSteps = 3;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        leading: BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
          builder: (context, state) {
            return IconButton(
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
            );
          },
        ),
        actions: [
          BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
            builder: (context, state) {
              return Container(
                width: 100,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: LinearProgressIndicator(
                  value:
                      (context.read<OnboardingFlowCubit>().state.detailsIndex +
                              1) /
                          _totalSteps,
                  backgroundColor: AppColors.inactiveProgressBar,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.activeDetailsProgressBar,
                  ),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(100),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildCurrentStepBody(),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildCurrentStepBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          switch (context.watch<OnboardingFlowCubit>().state.detailsIndex) {
            case 0:
              return StepWidget(
                title: 'Tell me some details please?',
                subtitle:
                    'Please provide a few details to help your friend find your activ account',
                body: (constraints) => UserDetailsWidget(
                  constraints: constraints,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  dobController: _dobController,
                  phoneNumberController: _phoneNumberController,
                  formKey: _formKey,
                ),
              );
            case 1:
              return const StepWidget(
                title: 'What is your Gender?',
                subtitle: 'This helps us find you more relevant content',
                body: GenderWidget.new,
              );
            case 2:
              return const StepWidget(
                title: 'What are your interests?',
                subtitle:
                    'Select your interests to personalize your experience',
                body: SportsSelectionWidget.new,
              );
            default:
              return const Center(child: Text('Unexpected step index.'));
          }
        },
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
      builder: (context, state) {
        switch (state.detailsIndex) {
          case 0:
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ActivButton(
                  text: Localization.continueText,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<OnboardingFlowCubit>().setUserInfo(
                            firstName: _firstNameController.text.trim(),
                            lastName: _lastNameController.text.trim(),
                            phoneNumber: _phoneNumberController.text.trim(),
                            dateOfBirth: _dobController.text.trim(),
                          );
                      context
                          .read<OnboardingFlowCubit>()
                          .setDetailsIndex(state.detailsIndex + 1);
                    }
                  },
                  isLoading: false,
                ),
              ),
            );

          case 1:
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
            );
          case 2:
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ActivButton(
                  disabled: state.selectedInterests.isEmpty,
                  text: 'Next',
                  onPressed: () {
                    ToastHelper.showSuccessToast('Onboarding Completed!!');
                  },
                  isLoading: false,
                ),
              ),
            );
          default:
            return const SizedBox.shrink();
        }
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
          disabled: currentIndex == 0,
          text: Localization.continueText,
          onPressed: () {
            if (isLastStep) {
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
