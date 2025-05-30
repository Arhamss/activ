import 'package:activ/core/field_validators.dart';
import 'package:activ/exports.dart';
import 'package:activ/utils/widgets/core_widgets/dropdown_textfield.dart';

class AddGameBottomSheet extends StatelessWidget {
  const AddGameBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final limitPlayersController = TextEditingController();
    final gameNameController = TextEditingController();
    final dateController = TextEditingController();
    final timeController = TextEditingController();

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          24,
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.bottomSheetCloseIcon,
                    size: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            DropdownTextField(
              controller: gameNameController,
              hintText: 'Select Game',
              validator: FieldValidators.textValidator,
              options: const [
                'Game 1',
                'Game 2',
                'Game 3',
              ],
            ),
            const SizedBox(height: 24),
            ActivTextField(
              controller: limitPlayersController,
              hintText: 'Limit Players',
              type: ActivTextFieldType.number,
              validator: FieldValidators.numberValidator,
            ),
            const SizedBox(height: 24),
            ActivTextField(
              controller: dateController,
              hintText: 'MM/DD/YYYY',
              type: ActivTextFieldType.datePicker,
              readOnly: true,
              showSuffixIcon: false,
              backgroundColor: AppColors.textFieldBackground,
            ),
            const SizedBox(height: 24),
            ActivTextField(
              controller: timeController,
              hintText: '01:30 PM',
              type: ActivTextFieldType.timePicker,
              readOnly: true,
              showSuffixIcon: false,
              validator: (value) => FieldValidators.timeValidator(
                value,
                DateTime.parse(dateController.text),
              ),
              backgroundColor: AppColors.textFieldBackground,
            ),
          ],
        ),
      ),
    );
  }
}
