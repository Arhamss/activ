import 'package:flutter/material.dart';
import 'package:activ/exports.dart';
import 'package:intl/intl.dart';

class ActivDatePicker extends StatefulWidget {
  const ActivDatePicker({
    required this.onDateSelected,
    required this.controller,
    super.key,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.hintText = 'Select Date',
  });

  // ignore: inference_failure_on_function_return_type
  final Function(DateTime) onDateSelected;
  final TextEditingController controller;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final String hintText;

  @override
  State<ActivDatePicker> createState() => _ActivDatePickerState();
}

class _ActivDatePickerState extends State<ActivDatePicker> {
  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onSurface: AppColors.primaryBrown,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      widget.controller.text = formattedDate;
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            hintText: widget.hintText,
            hintStyle: context.b2.copyWith(
              color: AppColors.lightText,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: const Icon(
              Icons.calendar_today_rounded,
              color: AppColors.greyShade2,
              size: 20,
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: context.b2.copyWith(
            color: AppColors.primaryBrown,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
