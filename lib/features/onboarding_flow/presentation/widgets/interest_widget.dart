import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InterestWidget extends StatelessWidget {
  const InterestWidget({
    required this.svgPath,
    required this.subtitle,
    required this.onTap,
    super.key,
    this.isSelected = false,
  });
  final String svgPath;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.selectedGender : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 54.57,
              offset: const Offset(0, 17.88),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.network(
                      svgPath,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: context.b2.copyWith(
                      fontSize: 15.04,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? AppColors.selectedGender
                          : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
