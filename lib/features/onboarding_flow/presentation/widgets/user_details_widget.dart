import 'package:activ/core/field_validators.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/features/onboarding_flow/presentation/cubit/state.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:activ/utils/widgets/core_widgets/phone_textfield.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    required this.constraints,
    required this.firstNameController,
    required this.lastNameController,
    required this.dobController,
    required this.phoneNumberController,
    required this.formKey,
    super.key,
  });

  final BoxConstraints constraints;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController dobController;
  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: constraints.maxHeight * 0.02),
              ActivImagePicker(
                imagePath: state.imagePath?.path,
                onButtonPressed: () {
                  context.read<OnboardingFlowCubit>().pickImage();
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ActivTextField(
                      controller: firstNameController,
                      hintText: Localization.firstName,
                      validator: FieldValidators.textValidator,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ActivTextField(
                      controller: lastNameController,
                      hintText: Localization.lastName,
                      validator: FieldValidators.textValidator,
                    ),
                  ),
                ],
              ),
              SizedBox(height: constraints.maxHeight * 0.03),
              SafeArea(
                child: PhoneInputField(
                  controller: phoneNumberController,
                  validator: FieldValidators.phoneNumberValidator,
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.03),
              SafeArea(
                child: ActivTextField(
                  controller: dobController,
                  hintText: Localization.dateOfBirth,
                  readOnly: true,
                  type: ActivTextFieldType.datePicker,
                  validator: FieldValidators.dateValidator,
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
            ],
          ),
        );
      },
    );
  }
}
