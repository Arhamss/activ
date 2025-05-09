import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:activ/constants/app_colors.dart';

extension AppTextStyle on BuildContext {
  TextStyle get h1 => GoogleFonts.urbanist(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryBrown,
      );

  TextStyle get h2 => GoogleFonts.urbanist(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryBrown,
      );

  TextStyle get h3 => GoogleFonts.urbanist(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryBrown,
      );

  // Titles
  TextStyle get t1 => GoogleFonts.urbanist(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryBrown,
      );

  TextStyle get t2 => GoogleFonts.urbanist(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryBrown,
      );

  TextStyle get t3 => GoogleFonts.urbanist(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryBrown,
      );

  // Body
  TextStyle get b1 => GoogleFonts.urbanist(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryBrown,
      );

  TextStyle get b2 => GoogleFonts.urbanist(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryBrown,
      );

  TextStyle get b3 => GoogleFonts.urbanist(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryBrown,
      );

  // Labels
  TextStyle get l1 => GoogleFonts.urbanist(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryBrown,
      );

  TextStyle get l2 => GoogleFonts.urbanist(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryBrown,
      );

  TextStyle get l3 => GoogleFonts.urbanist(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryBrown,
      );

  TextStyle get thickText => GoogleFonts.urbanist(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryBrown,
      );

  TextStyle get lightText => GoogleFonts.urbanist(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: AppColors.primaryBrown,
      );

  TextStyle get extraLightText => GoogleFonts.urbanist(
        fontSize: 18,
        fontWeight: FontWeight.w200,
        color: AppColors.primaryBrown,
      );

  TextStyle get italicBody => GoogleFonts.urbanist(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.primaryBrown,
      );
}
