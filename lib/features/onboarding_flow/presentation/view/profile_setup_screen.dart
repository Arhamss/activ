import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/StepWidget.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/gender_widget.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/sports_selection_widget.dart';
import 'package:activ/features/onboarding_flow/presentation/widgets/user_details_widget.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/helpers/focus_handler.dart';
import 'package:activ/utils/helpers/toast_helper.dart';
import 'package:activ/utils/widgets/core_widgets/phone_textfield.dart';
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
    return FocusHandler(
      child: Scaffold(
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: LinearProgressIndicator(
                    value: (context
                                .read<OnboardingFlowCubit>()
                                .state
                                .detailsIndex +
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
      ),
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
                title: Localization.profileSetupDetailsTitle,
                subtitle: Localization.profileSetupDetailsSubtitle,
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
              return StepWidget(
                title: Localization.profileSetupGenderTitle,
                subtitle: Localization.profileSetupGenderSubtitle,
                body: GenderWidget.new,
              );
            case 2:
              return StepWidget(
                title: Localization.profileSetupInterestsTitle,
                subtitle: Localization.profileSetupInterestsSubtitle,
                body: SportsSelectionWidget.new,
              );
            default:
              return Center(child: Text(Localization.unexpectedStepIndex));
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
                      final phoneState = context.read<PhoneFieldCubit>().state;
                      final formattedPhone =
                          '+${phoneState.country.phoneCode}${_phoneNumberController.text.trim()}';

                      context.read<OnboardingFlowCubit>().setUserInfo(
                            firstName: _firstNameController.text.trim(),
                            lastName: _lastNameController.text.trim(),
                            phoneNumber: formattedPhone,
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
                  disabled: state.selectedInterests.isEmpty ||
                      state.completeOnboarding.isLoading,
                  text: Localization.nextText,
                  onPressed: () {
                    context.read<OnboardingFlowCubit>().completeOnboarding();
                  },
                  isLoading: state.completeOnboarding.isLoading,
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
