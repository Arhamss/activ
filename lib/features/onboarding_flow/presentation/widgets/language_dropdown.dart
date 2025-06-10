import 'package:activ/core/locale/cubit/locale_cubit.dart';
import 'package:activ/exports.dart';
import 'package:flutter/material.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      height: 31,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(55),
        border: Border.all(
          color: AppColors.activeDetailsProgressBar,
          width: 0.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: context.watch<LocaleCubit>().state.locale.languageCode,
          style: context.b2.copyWith(
            color: AppColors.dropdownText,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          icon: SvgPicture.asset(
            AssetPaths.filledArrowDownIcon,
          ),
          dropdownColor: AppColors.white,
          items: [
            DropdownMenuItem<String>(
              value: 'en',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AssetPaths.worldIcon),
                  const SizedBox(width: 8),
                  const Text('English'),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            DropdownMenuItem<String>(
              value: 'ar',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AssetPaths.worldIcon),
                  const SizedBox(width: 8),
                  const Text('العربية'),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ],
          onChanged: (String? value) {
            if (value == null) return;
            context.read<LocaleCubit>().setLocale(value);
          },
        ),
      ),
    );
  }
}
