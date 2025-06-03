import 'package:flutter/material.dart';
import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';

class FeesSlider extends StatefulWidget {
  const FeesSlider({
    super.key,
    this.initialValue = 1,
    this.onChanged,
  });

  final double initialValue;
  final ValueChanged<double>? onChanged;

  @override
  State<FeesSlider> createState() => _FeesSliderState();
}

class _FeesSliderState extends State<FeesSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Fees',
              style: context.t1.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Text(
              'Max: \$ ${_value.toInt()}',
              style: context.t1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: SliderTheme(
            data: SliderThemeData(
              thumbSize: WidgetStateProperty.all(const Size(13, 13)),
              activeTrackColor: AppColors.secondaryColor,
              trackHeight: 4,
              inactiveTrackColor: AppColors.inactiveProgressBar,
              thumbColor: AppColors.secondaryColor,
              overlayColor: AppColors.secondaryColor.withOpacity(0.1),
            ),
            child: Slider(
              year2023: false,
              value: _value,
              min: 1,
              max: 60,
              onChanged: (value) {
                setState(() => _value = value);
                widget.onChanged?.call(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
