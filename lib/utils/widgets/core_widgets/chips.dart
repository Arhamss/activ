import 'package:activ/exports.dart';

class ActivChip extends StatelessWidget {
  const ActivChip({
    required this.text,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  final bool isSelected;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.activeDetailsProgressBar
              : Colors.transparent,
          borderRadius: BorderRadius.circular(7), // Adjusted border radius
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.textFieldBackground,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ), // Adjusted padding
        child: Text(
          text,
          style: context.b2.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: isSelected ? AppColors.white : AppColors.lightText,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
