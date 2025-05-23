import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class StepScreen extends StatelessWidget {
  const StepScreen({
    required this.title,
    required this.subtitle,
    required this.body,
    super.key,
  });
  final String title;
  final String subtitle;
  final Widget Function(BoxConstraints constraints) body;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            width: constraints.maxWidth,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  title,
                  style: context.b2.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  subtitle,
                  style: context.b2.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                body(constraints),
              ],
            ),
          ),
        );
      },
    );
  }
}
