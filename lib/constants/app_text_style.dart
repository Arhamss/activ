import 'package:activ/constants/app_colors.dart';
import 'package:activ/core/locale/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension AppTextStyle on BuildContext {
  bool get _isArabic {
    final locale = watch<LocaleCubit>().state.locale.languageCode.toLowerCase();
    return locale == 'ar';
  }

  String get _fontFamily => _isArabic ? 'NotoSansArabic' : 'Urbanist';

  // Headlines
  TextStyle get h1 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      );

  TextStyle get h2 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      );

  TextStyle get h3 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      );

  // Titles
  TextStyle get t1 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      );

  TextStyle get t2 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      );

  TextStyle get t3 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      );

  // Body
  TextStyle get b1 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      );

  TextStyle get b2 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      );

  TextStyle get b3 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      );

  // Labels
  TextStyle get l1 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      );

  TextStyle get l2 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      );

  TextStyle get l3 => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      );

  TextStyle get thickText => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      );

  TextStyle get lightText => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: AppColors.black,
      );

  TextStyle get extraLightText => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w200,
        color: AppColors.black,
      );

  TextStyle get italicBody => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.black,
      );
}
