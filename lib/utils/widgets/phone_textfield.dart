import 'package:activ/features/onboarding_flow/presentation/cubit/cubit.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:activ/exports.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class PhoneInputField extends StatefulWidget {
  const PhoneInputField({
    required this.controller,
    super.key,
    this.validator,
  });

  final String? Function(String?, IsoCode?)? validator;
  final TextEditingController controller;

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _selectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        context.read<PhoneFieldCubit>().setCountryCode(country);
      },
    );
  }

  String? _validate(String? value) {
    final isoCode = IsoCode.values.firstWhere(
      (iso) =>
          iso.name.split('.').last ==
          context.read<PhoneFieldCubit>().state.country.countryCode,
    );

    final customError = widget.validator?.call(value, isoCode);

    // If custom validation passes (or isn't provided), check type-based validation
    final typeError = customError;
    // if (typeError == true) {
    //   context.read<PhoneFieldCubit>().setError('Invalid Phone Number');
    //   context.read<PhoneFieldCubit>().setIsValid(false);
    //   return 'Invalid Phone Number';
    // } else {
    //   context.read<PhoneFieldCubit>().setError('');
    //   context.read<PhoneFieldCubit>().setIsValid(true);
    //   return 'Valid Phone Number';
    // }

    return typeError;
  }

  @override
  Widget build(BuildContext context) {
    final phoneFieldState = context.watch<PhoneFieldCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _focusNode.hasFocus
                  ? AppColors.primaryColor
                  : AppColors.greyShade6,
            ),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: _selectCountry,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        phoneFieldState.country.flagEmoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '+${phoneFieldState.country.phoneCode}',
                        style: context.b2.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.greyShade2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        AssetPaths.arrowDown,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: phoneFieldState.country.example,
                    hintStyle: context.b2.copyWith(
                      color: AppColors.greyShade2.withOpacity(0.4),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    errorStyle:
                        const TextStyle(height: 0), // Hide the default error
                  ),
                  style: context.b2.copyWith(
                    color: AppColors.primaryBrown,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  validator: _validate,
                ),
              ),
            ],
          ),
        ),
        if (phoneFieldState.isValid == false)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(
              phoneFieldState.error,
              style: context.b2.copyWith(
                color: AppColors.error,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}

// Phone Field State
class PhoneFieldState extends Equatable {
  const PhoneFieldState({
    required this.country,
    this.phoneNumber = '',
    this.isValid = true,
    this.error = '',
  });
  final String phoneNumber;
  final Country country;
  final bool isValid;
  final String error;

  PhoneFieldState copyWith({
    String? phoneNumber,
    Country? country,
    bool? isValid,
    String? error,
  }) {
    return PhoneFieldState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        country,
        isValid,
        error,
      ];
}

class PhoneFieldCubit extends Cubit<PhoneFieldState> {
  PhoneFieldCubit() : super(PhoneFieldState(country: Country.parse('US')));

  void setPhoneNumber(String phone) {
    emit(
      state.copyWith(
        phoneNumber: phone,
      ),
    );
  }

  void setCountryCode(Country country) {
    emit(
      state.copyWith(
        country: country,
      ),
    );
  }

  void setError(String error) {
    emit(
      state.copyWith(
        error: error,
      ),
    );
  }

  void setIsValid(bool value) {
    emit(
      state.copyWith(
        isValid: value,
      ),
    );
  }
}
