import 'package:activ/core/field_validators.dart';
import 'package:activ/core/locale/cubit/locale_cubit.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:activ/utils/widgets/core_widgets/image_picker.dart';
import 'package:activ/utils/widgets/phone_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailsStep1Screen extends StatelessWidget {
  DetailsStep1Screen(this.constraints, {super.key});

  final BoxConstraints constraints;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: constraints.maxHeight * 0.1),
              ActivImagePicker(
                imagePath: state.imagePath,
                onImagePicked: (String) {
                  context.read<OnboardingFlowCubit>().setImagePath(String);
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ActivTextField(
                      controller: firstNameController,
                      hintText: 'First Name',
                      validator: FieldValidators.textValidator,
                    ),
                  ),
                  const SizedBox(width: 16), // Add spacing between the fields
                  Expanded(
                    child: ActivTextField(
                      controller: lastNameController,
                      hintText: 'Last Name',
                      validator: FieldValidators.textValidator,
                    ),
                  ),
                ],
              ),
              SizedBox(height: constraints.maxHeight * 0.03),
              PhoneInputField(
                controller: phoneNumberController,
                validator: FieldValidators.phoneNumberValidator,
              ),
              SizedBox(height: constraints.maxHeight * 0.03),
              ActivTextField(
                controller: dobController,
                hintText: 'Date of Birth',
                readOnly: true,
                type: ActivTextFieldType.datePicker,
                validator: FieldValidators.dateValidator,
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              ActivButton(
                text: Localization.continueText,
                onPressed: () {
                  AppLogger.info(firstNameController.text);
                  AppLogger.info(lastNameController.text);
                  AppLogger.info(phoneNumberController.text);
                  AppLogger.info(dobController.text);

                  if (formKey.currentState!.validate()) {
                    context.read<OnboardingFlowCubit>().setFirstName(
                          firstNameController.text.trim(),
                        );
                    context.read<OnboardingFlowCubit>().setLastName(
                          lastNameController.text.trim(),
                        );
                    context.read<OnboardingFlowCubit>().setPhoneNumber(
                          phoneNumberController.text.trim(),
                        );
                    context.read<OnboardingFlowCubit>().setDatePicked(
                          dobController.text.trim(),
                        );
                    context.read<OnboardingFlowCubit>().setDetailsIndex(
                          state.detailsIndex + 1,
                        );
                  }
                },
                isLoading: state.screen1Done.isLoaded,
              ),
            ],
          ),
        );
      },
    );
  }
}
