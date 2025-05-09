import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:activ/exports.dart';

enum ActivTextFieldType { email, password, description, number, text }

class ActivTextField extends StatefulWidget {
  const ActivTextField({
    required this.controller,
    this.padding = EdgeInsets.zero,
    this.labelText,
    this.hintText,
    this.hintColor,
    this.type = ActivTextFieldType.text,
    this.validator,
    this.prefixPath,
    this.suffixPath,
    this.contentPadding,
    this.readOnly,
    this.descriptionMaxCharacter = 200,
    this.regularMaxCharacter = 100,
    this.onTap,
    this.onChanged,
    this.borderRadius,
    super.key,
  });

  final TextEditingController controller;
  final EdgeInsetsGeometry padding;
  final String? labelText;
  final String? hintText;
  final Color? hintColor;
  final ActivTextFieldType type;
  final String? Function(String?)? validator;
  final String? prefixPath;
  final String? suffixPath;
  final EdgeInsetsGeometry? contentPadding;
  final bool? readOnly;
  final VoidCallback? onTap;
  final int regularMaxCharacter;
  final int descriptionMaxCharacter;
  final void Function(String)? onChanged;
  final double? borderRadius;

  @override
  State<ActivTextField> createState() => _ActivTextFieldState();
}

class _ActivTextFieldState extends State<ActivTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _obscureText = true;
  String? _errorText;

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
    final isPassword = widget.type == ActivTextFieldType.password;
    final isEmail = widget.type == ActivTextFieldType.email;
    final isDescription = widget.type == ActivTextFieldType.description;
    final isNumber = widget.type == ActivTextFieldType.number;

    final borderColor = _errorText != null
        ? AppColors.error
        : _focusNode.hasFocus
            ? AppColors.primaryColor
            : AppColors.greyShade7;

    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        isDescription ? 24 : widget.borderRadius ?? 100,
      ),
      borderSide: BorderSide(
        color: borderColor,
      ),
    );

    final iconColor =
        _errorText != null ? AppColors.error : AppColors.secondaryColor;

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
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                isDescription ? 24 : widget.borderRadius ?? 12,
              ),
            ),
            child: TextFormField(
              focusNode: _focusNode,
              obscuringCharacter: '*',
              controller: widget.controller,
              obscureText: isPassword ? _obscureText : false,
              readOnly: widget.readOnly ?? false,
              keyboardType: isEmail
                  ? TextInputType.emailAddress
                  : isPassword
                      ? TextInputType.visiblePassword
                      : isNumber
                          ? TextInputType.number
                          : TextInputType.text,
              maxLines: isDescription ? 5 : 1,
              maxLength: isDescription
                  ? widget.descriptionMaxCharacter
                  : widget.regularMaxCharacter,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              inputFormatters:
                  isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              validator: _validate,
              style: GoogleFonts.urbanist(
                color: AppColors.primaryBrown,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              cursorColor: AppColors.primaryBrown,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                counterText: '',
                hintText: widget.hintText,
                hintStyle: GoogleFonts.urbanist(
                  color: AppColors.lightText,
                  fontWeight: FontWeight.w500,
                ),
                errorStyle: const TextStyle(fontSize: 0, height: 0),
                border: baseBorder,
                enabledBorder: baseBorder,
                focusedBorder: baseBorder,
                errorBorder: baseBorder,
                focusedErrorBorder: baseBorder,
                prefixIconConstraints: const BoxConstraints(minWidth: 40),
                suffixIconConstraints: const BoxConstraints(minWidth: 40),
                prefixIcon: widget.prefixPath != null
                    ? Padding(
                        padding: const EdgeInsetsDirectional.only(start: 12),
                        child: SvgPicture.asset(
                          widget.prefixPath!,
                          colorFilter:
                              ColorFilter.mode(iconColor, BlendMode.srcIn),
                        ),
                      )
                    : null,
                suffixIcon: _buildSuffixIcon(iconColor, isPassword),
                contentPadding: isDescription
                    ? const EdgeInsetsDirectional.only(start: 16, top: 24)
                    : widget.contentPadding ??
                        const EdgeInsetsDirectional.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
              ),
            ),
          ),
          if (_errorText != null) ...[
            const SizedBox(height: 6),
            Text(
              _errorText!,
              style: const TextStyle(
                color: AppColors.error,
                fontSize: 13,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget? _buildSuffixIcon(Color iconColor, bool isPassword) {
    if (widget.suffixPath != null) {
      return SvgPicture.asset(
        widget.suffixPath!,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      );
    } else if (isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: iconColor,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return null;
  }
}
