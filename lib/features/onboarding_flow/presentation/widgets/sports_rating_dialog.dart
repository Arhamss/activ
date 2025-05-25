import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:activ/exports.dart';

class SportRatingDialog extends StatefulWidget {
  const SportRatingDialog({
    required this.sportName,
    super.key,
  });

  final String sportName;

  @override
  State<SportRatingDialog> createState() => _SportRatingDialogState();
}

class _SportRatingDialogState extends State<SportRatingDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              'How do you rate yourself in ${widget.sportName}?',
              textAlign: TextAlign.center,
              style: context.b2.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'This helps us find and connect you to relevant people',
              textAlign: TextAlign.center,
              style: context.b2.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 255,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(5, (index) {
                  final isSelected = index <
                      context.watch<SportsDialogCubit>().state.selectedRating;
                  return GestureDetector(
                    onTap: () {
                      context.read<SportsDialogCubit>().selectRating(index + 1);
                    },
                    child: SvgPicture.asset(
                      isSelected
                          ? AssetPaths
                              .selectedStarIcon // Path to selected star SVG
                          : AssetPaths
                              .unselectedStarIcon, // Path to unselected star SVG
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 48),
            BlocBuilder<SportsDialogCubit, SportsDialogState>(
              builder: (context, state) {
                return ActivButton(
                  onPressed: () {
                    context.pop(); // Return selected rating
                  },
                  text: 'Continue',
                  isLoading: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SportsDialogState extends Equatable {
  const SportsDialogState({this.selectedRating = 0});
  final int selectedRating;

  @override
  List<Object> get props => [selectedRating];

  SportsDialogState copyWith({int? selectedRating}) {
    return SportsDialogState(
      selectedRating: selectedRating ?? this.selectedRating,
    );
  }
}

class SportsDialogCubit extends Cubit<SportsDialogState> {
  SportsDialogCubit() : super(const SportsDialogState());

  void selectRating(int rating) {
    emit(state.copyWith(selectedRating: rating));
  }

  void resetRating() {
    emit(const SportsDialogState());
  }
}
