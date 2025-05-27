import 'package:activ/exports.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:equatable/equatable.dart';

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
  double currentRating = 0;

  @override
  void initState() {
    super.initState();
    currentRating = context.read<SportsDialogCubit>().state.selectedRating;
  }

  void _updateRatingFromDrag(DragUpdateDetails details) {
    final delta = details.delta.dx / 50;
    setState(() {
      currentRating = (currentRating + delta).clamp(0.0, 5.0);
      context.read<SportsDialogCubit>().selectRating(currentRating);
    });
  }

  Widget _buildStar(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: currentRating),
      duration: const Duration(milliseconds: 300),
      builder: (context, animatedRating, child) {
        final icon = animatedRating >= index + 1
            ? AssetPaths.filledStarIcon
            : animatedRating >= index + 0.5
                ? AssetPaths.halfStarIcon
                : AssetPaths.outlinedStarIcon;

        return GestureDetector(
          onTapDown: (details) {
            final tapX = details.localPosition.dx;
            const starWidth = 40.0;
            final isHalf = tapX < (starWidth / 2);

            setState(() {
              currentRating = index + (isHalf ? 0.5 : 1.0);
              context.read<SportsDialogCubit>().selectRating(currentRating);
            });
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: SvgPicture.asset(
              icon,
              key: ValueKey(icon),
              width: 40,
              height: 40,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.darkWhiteBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24),
            Text(
              Localization.howDoYouRateYourselfIn(widget.sportName),
              textAlign: TextAlign.center,
              style: context.b2.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              Localization.thisHelpsUsFindAndConnectYouToRelevantPeople,
              textAlign: TextAlign.center,
              style: context.b2.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onHorizontalDragUpdate: _updateRatingFromDrag,
              child: SizedBox(
                width: 255,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(5, _buildStar),
                ),
              ),
            ),
            const SizedBox(height: 48),
            BlocBuilder<SportsDialogCubit, SportsDialogState>(
              builder: (context, state) {
                return ActivButton(
                  onPressed: () {
                    context.pop();
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
  const SportsDialogState({this.selectedRating = 0.0});

  final double selectedRating;

  @override
  List<Object> get props => [selectedRating];

  SportsDialogState copyWith({double? selectedRating}) {
    return SportsDialogState(
      selectedRating: selectedRating ?? this.selectedRating,
    );
  }
}

class SportsDialogCubit extends Cubit<SportsDialogState> {
  SportsDialogCubit() : super(const SportsDialogState());

  void selectRating(double rating) {
    emit(state.copyWith(selectedRating: rating));
  }

  void resetRating() {
    emit(const SportsDialogState());
  }
}
