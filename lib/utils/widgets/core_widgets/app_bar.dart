import 'package:activ/exports.dart';

PreferredSizeWidget activAppBar({
  required BuildContext context,
  required String title,
  VoidCallback? onLeadingPressed,
  String? actionText,
  TextStyle? titleStyle,
  TextStyle? actionTextStyle,
  Widget? actionWidget,
  double elevation = 0.0,
  bool forceMaterialTransparency = true,
  bool centerTitle = false,
  double titleSpacing = 16.0,
  Widget? leadingIcon,
  bool showLeading = true,
  double actionsPadding = 16,
  Color? backgroundColor,
  double? height,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height ?? 80),
    child: AppBar(
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      elevation: elevation,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      leadingWidth: 64,
      toolbarHeight: height ?? 80,
      automaticallyImplyLeading: showLeading,
      leading: leadingIcon != null
          ? IconButton(
              onPressed: onLeadingPressed,
              icon: leadingIcon,
              color: AppColors.white,
            )
          : null,
      title: Text(
        title,
        style: titleStyle ??
            context.b1.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: AppColors.white,
            ),
      ),
      actions: actionText != null
          ? [
              Text(
                actionText,
                style: actionTextStyle ?? context.b2,
              ),
              const SizedBox(width: 16),
            ]
          : actionWidget != null
              ? [
                  actionWidget,
                  SizedBox(width: actionsPadding),
                ]
              : [],
    ),
  );
}
