import 'package:activ/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ActivIconButton extends StatelessWidget {
  const ActivIconButton({
    this.icon,
    this.onPressed,
    this.backgroundColor = AppColors.primaryOrange,
    this.iconColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(50)),
    this.borderColor = Colors.transparent,
    this.iconSize = 24.0,
    this.splashColor = Colors.black12,
    this.outsidePadding = EdgeInsetsDirectional.zero,
    this.iconPadding,
    this.borderWidth = 1,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color? iconColor;
  final BorderRadiusGeometry borderRadius;
  final Color borderColor;
  final double iconSize;
  final Color splashColor;
  final Widget? icon;
  final double? iconPadding;
  final EdgeInsetsDirectional outsidePadding;
  final bool isLoading;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outsidePadding,
      child: IconButton(
        onPressed: isLoading == true ? null : onPressed ?? () => context.pop(),
        icon: isLoading
            ? const Padding(
                padding: EdgeInsets.all(18),
                child: LoadingWidget(
                  size: 18,
                ),
              )
            : icon ?? const SizedBox(),
        color: iconColor,
        style: IconButton.styleFrom(
          padding: EdgeInsets.all(iconPadding ?? 0),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
        ),
      ),
    );
  }
}
