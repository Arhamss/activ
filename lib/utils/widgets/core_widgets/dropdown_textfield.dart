import 'package:activ/exports.dart';

class DropdownTextField extends StatefulWidget {
  const DropdownTextField({
    required this.controller,
    required this.options,
    this.padding = EdgeInsets.zero,
    this.labelText,
    this.hintText,
    this.validator,
    this.onChanged,
    this.borderRadius,
    this.prefixIconPath,
    super.key,
  });

  final TextEditingController controller;
  final List<String> options;
  final EdgeInsetsGeometry padding;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final double? borderRadius;
  final String? prefixIconPath;

  @override
  State<DropdownTextField> createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  final FocusNode _focusNode = FocusNode();
  String? _errorText;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    final error = widget.validator?.call(value);
    setState(() {
      _errorText = error;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _errorText != null
        ? AppColors.error
        : (_focusNode.hasFocus || _isMenuOpen)
            ? AppColors.primaryColor
            : AppColors.greyShade6;

    final iconColor = _errorText != null
        ? AppColors.error
        : (_focusNode.hasFocus || _isMenuOpen)
            ? AppColors.primaryColor
            : AppColors.secondaryColor;

    // Create text styles in build method to avoid context issues
    final baseTextStyle = context.b2.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 14,
    );

    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null) ...[
            Text(
              widget.labelText!,
              style: context.t1.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryBrown,
              ),
            ),
            const SizedBox(height: 8),
          ],
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width - 48,
              maxWidth: MediaQuery.of(context).size.width - 48,
            ),
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: AppColors.greyShade6,
              ),
            ),
            shadowColor: Colors.black.withOpacity(0.08),
            elevation: 8,
            onOpened: () {
              setState(() => _isMenuOpen = true);
              _focusNode.requestFocus();
            },
            onCanceled: () {
              setState(() => _isMenuOpen = false);
              _focusNode.unfocus();
            },
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  // Prefix icon
                  if (widget.prefixIconPath != null) ...[
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12),
                      child: SvgPicture.asset(
                        widget.prefixIconPath!,
                        colorFilter:
                            ColorFilter.mode(iconColor, BlendMode.srcIn),
                      ),
                    ),
                  ],

                  // Text content
                  Expanded(
                    child: Text(
                      widget.controller.text.isNotEmpty
                          ? widget.controller.text
                          : widget.hintText ?? '',
                      style: baseTextStyle.copyWith(
                        color: widget.controller.text.isNotEmpty
                            ? AppColors.textDark
                            : AppColors.lightText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Dropdown arrow
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 12),
                    child: SvgPicture.asset(
                      AssetPaths.dropdownArrow,
                    ),
                  ),
                ],
              ),
            ),
            itemBuilder: (context) => widget.options.map((option) {
              final isSelected = widget.controller.text == option;
              return PopupMenuItem<String>(
                value: option,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: isSelected
                      ? BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        )
                      : null,
                  child: Text(
                    option,
                    style: baseTextStyle.copyWith(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.textDark,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            onSelected: (value) {
              widget.controller.text = value;
              widget.onChanged?.call(value);
              _validate(value);
              setState(() => _isMenuOpen = false);
              _focusNode.unfocus();
            },
          ),
          if (_errorText != null) ...[
            const SizedBox(height: 6),
            Text(
              _errorText!,
              style: baseTextStyle.copyWith(
                color: AppColors.error,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
