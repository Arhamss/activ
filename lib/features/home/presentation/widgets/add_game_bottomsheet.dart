import 'package:activ/core/enums/sports_enums.dart';
import 'package:activ/core/field_validators.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/home/presentation/cubit/cubit.dart';
import 'package:activ/features/home/presentation/cubit/state.dart';
import 'package:activ/utils/extensions/null_check.dart';
import 'package:activ/utils/helpers/datetime_helper.dart';
import 'package:activ/utils/widgets/core_widgets/dropdown_textfield.dart';
import 'package:activ/utils/widgets/core_widgets/mb_text_button.dart';
import 'package:activ/utils/widgets/core_widgets/slider.dart';

class AddGameBottomSheet extends StatelessWidget {
  const AddGameBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final limitPlayersController = TextEditingController();
    final gameNameController = TextEditingController();
    final dateController = TextEditingController();
    final timeController = TextEditingController();

    return Form(
      key: formKey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            // Fixed header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
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
            ),

            // Scrollable content
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownTextField(
                          controller: gameNameController,
                          hintText: 'Select Game',
                          validator: FieldValidators.textValidator,
                          options: state.user.data?.sports
                                  .map((e) => e.name)
                                  .toList() ??
                              [],
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
                          backgroundColor: AppColors.textFieldBackground,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Game Organiser Payment',
                          style: context.b1.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.lightText,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const FeesSlider(),
                        const SizedBox(height: 16),
                        Text(
                          'Select Game Level',
                          style: context.b1.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                ActivChip(
                                  text: 'Beginner',
                                  isSelected: state.levels.contains('Beginner'),
                                  onTap: () {
                                    if (state.levels.contains('Beginner')) {
                                      context
                                          .read<HomeCubit>()
                                          .removeLevel('Beginner');
                                    } else {
                                      context
                                          .read<HomeCubit>()
                                          .addLevel('Beginner');
                                    }
                                  },
                                ),
                                ActivChip(
                                  text: 'Intermediate',
                                  isSelected:
                                      state.levels.contains('Intermediate'),
                                  onTap: () {
                                    if (state.levels.contains('Intermediate')) {
                                      context
                                          .read<HomeCubit>()
                                          .removeLevel('Intermediate');
                                    } else {
                                      context
                                          .read<HomeCubit>()
                                          .addLevel('Intermediate');
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Location',
                          style: context.b1.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ActivButton(
                                  isLoading: false,
                                  text: state.selectedLocation != null
                                      ? '${state.selectedLocation?.address}'
                                      : 'Select Location',
                                  backgroundColor: AppColors.white,
                                  textColor: AppColors.primaryColor,
                                  borderColor:
                                      AppColors.activeDetailsProgressBar,
                                  borderStyle: state.selectedLocation != null
                                      ? ButtonBorderStyle.solid
                                      : ButtonBorderStyle.dotted,
                                  textStyle: context.b3.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.lightText,
                                  ),
                                  onPressed: state.selectedLocation.isNotNull
                                      ? null
                                      : () {
                                          context.pushNamed(
                                            AppRouteNames.locationPickerScreen,
                                          );
                                        },
                                ),
                                if (state.selectedLocation.isNotNull)
                                  ActivTextButton(
                                    onPressed: () {
                                      context.pushNamed(
                                        AppRouteNames.locationPickerScreen,
                                      );
                                    },
                                    text: 'Choose on Map',
                                    textStyle: context.b2.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.activeDetailsProgressBar,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: ActivButton(
                                isLoading: state.addGame.isLoading,
                                text: 'Create Game',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    final dateTime =
                                        DateTimeHelper.combineToIsoString(
                                      dateController: dateController,
                                      timeController: timeController,
                                    );

                                    final selectedGame =
                                        state.user.data?.sports.firstWhere(
                                      (sport) =>
                                          sport.name == gameNameController.text,
                                    );

                                    context.read<HomeCubit>().addGame(
                                          state.selectedLocation!,
                                          selectedGame?.id ?? '',
                                          limitPlayersController.text,
                                          state.levels.first,
                                          int.parse(
                                            limitPlayersController.text,
                                          ),
                                          dateTime,
                                        );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
