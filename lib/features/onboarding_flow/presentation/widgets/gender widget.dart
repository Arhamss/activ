import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderOptionWidget extends StatelessWidget {
  const GenderOptionWidget({
    required this.svgAsset,
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });
  final String svgAsset;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? AppColors.selectedGender
                : AppColors.unSelectedGender,
            width: isSelected ? 3 : 0.95,
          ),
          borderRadius: BorderRadius.circular(7.62),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.b2.copyWith(
                fontSize: 15.25,
                fontWeight: FontWeight.w800,
                color: isSelected
                    ? AppColors.selectedGender
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SvgPicture.asset(
                  svgAsset,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
