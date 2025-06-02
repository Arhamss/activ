import 'package:activ/exports.dart';

enum ButtonBorderStyle { solid, dotted }

class ActivButton extends StatelessWidget {
  const ActivButton({
    required this.text,
    required this.onPressed,
    required this.isLoading,
    super.key,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = AppColors.white,
    this.disabledTextColor = AppColors.white,
    this.disabledBackgroundColor,
    this.borderRadius = 16,
    this.padding =
        const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
    this.fontWeight = FontWeight.w700,
    this.splashColor = Colors.black12,
    this.fontSize = 16,
    this.prefixIcon,
    this.suffixIcon,
    this.outsidePadding = const EdgeInsetsDirectional.all(4),
    this.isExpanded = true,
    this.iconSpacing,
    this.disabled = false,
    this.loadingColor = AppColors.white,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderStyle = ButtonBorderStyle.solid,
    this.textStyle,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsDirectional padding;
  final FontWeight fontWeight;
  final Color splashColor;
  final double fontSize;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsDirectional? outsidePadding;
  final bool isExpanded;
  final double? iconSpacing;
  final bool disabled;
  final Color disabledTextColor;
  final Color? disabledBackgroundColor;
  final Color loadingColor;
  final Color? borderColor;
  final double borderWidth;
  final ButtonBorderStyle borderStyle;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final effectiveDisabledBackgroundColor =
        disabledBackgroundColor ?? backgroundColor.withValues(alpha: 0.5);

    final buttonContent = TextButton(
      onPressed: (isLoading || disabled) ? null : onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        backgroundColor:
            disabled ? effectiveDisabledBackgroundColor : backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: borderColor != null && borderStyle == ButtonBorderStyle.solid
              ? BorderSide(
                  color: disabled
                      ? borderColor!.withValues(alpha: 0.5)
                      : borderColor!,
                  width: borderWidth,
                )
              : BorderSide.none,
        ),
        splashFactory: InkRipple.splashFactory,
        overlayColor: splashColor,
      ),
      child: Padding(
        padding: padding,
        child: isLoading
            ? SizedBox(
                height: 26,
                width: 26,
                child: LoadingWidget(
                  color: textColor,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    SizedBox(width: iconSpacing ?? 8),
                  ],
                  Flexible(
                    child: Text(
                      text.toUpperCase(),
                      style: textStyle ??
                          context.b3.copyWith(
                            color: disabled ? disabledTextColor : textColor,
                            fontWeight: fontWeight,
                            fontSize: fontSize,
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    SizedBox(width: iconSpacing ?? 8),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );

    Widget finalButton = buttonContent;

    // Add dotted border if specified
    if (borderColor != null && borderStyle == ButtonBorderStyle.dotted) {
      finalButton = CustomPaint(
        painter: DottedBorderPainter(
          color: disabled ? borderColor!.withValues(alpha: 0.5) : borderColor!,
          strokeWidth: borderWidth,
          borderRadius: borderRadius,
        ),
        child: buttonContent,
      );
    }

    return Padding(
      padding: outsidePadding ?? EdgeInsets.zero,
      child: isExpanded
          ? Row(
              children: [
                Expanded(child: finalButton),
              ],
            )
          : finalButton,
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  const DottedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.borderRadius,
    this.dashLength = 4.0,
    this.gapLength = 4.0,
  });

  final Color color;
  final double strokeWidth;
  final double borderRadius;
  final double dashLength;
  final double gapLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      final pathLength = pathMetric.length;
      var distance = 0.0;
      var draw = true;

      while (distance < pathLength) {
        final length = draw ? dashLength : gapLength;
        if (distance + length > pathLength) {
          if (draw) {
            final extractPath = pathMetric.extractPath(distance, pathLength);
            canvas.drawPath(extractPath, paint);
          }
          break;
        } else {
          if (draw) {
            final extractPath =
                pathMetric.extractPath(distance, distance + length);
            canvas.drawPath(extractPath, paint);
          }
          distance += length;
          draw = !draw;
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DottedBorderPainter &&
        other.color == color &&
        other.strokeWidth == strokeWidth &&
        other.borderRadius == borderRadius &&
        other.dashLength == dashLength &&
        other.gapLength == gapLength;
  }

  @override
  int get hashCode {
    return Object.hash(
      color,
      strokeWidth,
      borderRadius,
      dashLength,
      gapLength,
    );
  }
}
