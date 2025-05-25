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
      useSafeArea: true,
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

    final typeError = customError;

    context.read<PhoneFieldCubit>().setError(typeError ?? '');
    context.read<PhoneFieldCubit>().setIsValid(typeError == null);
    return typeError;
  }

  @override
  Widget build(BuildContext context) {
    final phoneFieldState = context.watch<PhoneFieldCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            prefixIcon: GestureDetector(
              onTap: _selectCountry,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                    const SizedBox(width: 8),
                    const VerticalDivider(
                      color: AppColors.greyShade6,
                      width: 1,
                      thickness: 1,
                      indent: 8,
                      endIndent: 8,
                    ),
                  ],
                ),
              ),
            ),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.greyShade6,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.greyShade6,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.error,
              ),
            ),
            errorStyle: const TextStyle(
                height: 0, fontSize: 0), // Hide default error style
          ),
          style: context.b2.copyWith(
            color: AppColors.primaryBrown,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          validator: _validate,
        ),
        if (phoneFieldState.isValid == false) ...[
          const SizedBox(height: 6),
          Text(
            phoneFieldState.error,
            style: context.b2.copyWith(
              color: AppColors.error,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
