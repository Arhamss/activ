import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    required this.text,
    required this.svgPath,
    required this.onPressed,
    super.key,
    this.backgroundColor = AppColors.bluePrimary,
    this.textColor = AppColors.black,
    this.height = 56.0,
  });

  final String text;
  final String svgPath;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  svgPath,
                ),
              ),
              const SizedBox(width: 16),
              Center(
                child: Text(
                  text,
                  style: context.b2.copyWith(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
