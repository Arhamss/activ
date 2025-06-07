import 'package:activ/exports.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

enum ActivTextFieldType {
  email,
  password,
  description,
  number,
  text,
  confirmPassword,
  datePicker,
  timePicker
}

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
    this.passwordToMatch,
    this.backgroundColor,
    this.showSuffixIcon,
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
  final String? passwordToMatch;
  final Color? backgroundColor;
  final bool? showSuffixIcon;

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
    final customError = widget.validator?.call(value);
    final typeError = customError;

    setState(() {
      _errorText = typeError;
    });

    return typeError;
  }

  Future<void> _handleDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(widget.controller.text) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onSurface: AppColors.textDark,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                textStyle: context.b2.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.white,
              headerBackgroundColor: AppColors.primaryColor,
              headerForegroundColor: AppColors.white,
              weekdayStyle: context.b2.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              dayStyle: context.b2.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              yearStyle: context.b2.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              headerHeadlineStyle: context.b2.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              headerHelpStyle: context.b2.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              rangePickerHeaderHeadlineStyle: context.b2.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              rangePickerHeaderHelpStyle: context.b2.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      widget.controller.text = formattedDate;
      widget.onChanged?.call(formattedDate);
    }
  }

  Future<void> _handleTimePicker() async {
    var initialTime = DateTime.now();

    // Try to parse existing time from controller
    if (widget.controller.text.isNotEmpty) {
      try {
        final timeFormat = DateFormat('hh:mm a');
        final parsedTime = timeFormat.parse(widget.controller.text);
        final now = DateTime.now();
        initialTime = DateTime(
          now.year,
          now.month,
          now.day,
          parsedTime.hour,
          parsedTime.minute,
        );
      } catch (e) {
        // If parsing fails, use current time
        initialTime = DateTime.now();
      }
    }

    showCupertinoModalPopup<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        var tempPickedTime = initialTime;

        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          height: 300,
          child: Column(
            children: [
              // Header with cancel and done buttons
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: context.b2.copyWith(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        final formattedTime =
                            DateFormat('hh:mm a').format(tempPickedTime);
                        widget.controller.text = formattedTime;
                        widget.onChanged?.call(formattedTime);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Done',
                        style: context.b2.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Time picker
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: initialTime,
                  onDateTimeChanged: (DateTime newTime) {
                    tempPickedTime = newTime;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.type == ActivTextFieldType.password ||
        widget.type == ActivTextFieldType.confirmPassword;
    final isDescription = widget.type == ActivTextFieldType.description;
    final isNumber = widget.type == ActivTextFieldType.number;
    final isDatePicker = widget.type == ActivTextFieldType.datePicker;
    final isTimePicker = widget.type == ActivTextFieldType.timePicker;

    final borderColor = _errorText != null
        ? AppColors.error
        : _focusNode.hasFocus
            ? AppColors.primaryColor
            : AppColors.greyShade6;

    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        isDescription ? 24 : widget.borderRadius ?? 12,
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
          GestureDetector(
            onTap: isDatePicker
                ? _handleDatePicker
                : isTimePicker
                    ? _handleTimePicker
                    : null,
            child: AbsorbPointer(
              absorbing: isDatePicker || isTimePicker,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    isDescription ? 24 : widget.borderRadius ?? 12,
                  ),
                ),
                child: TextFormField(
                  focusNode: _focusNode,
                  controller: widget.controller,
                  obscureText: isPassword ? _obscureText : false,
                  readOnly: widget.readOnly ?? isDatePicker || isTimePicker,
                  keyboardType: isPassword
                      ? TextInputType.visiblePassword
                      : isNumber
                          ? TextInputType.number
                          : TextInputType.text,
                  maxLines: isDescription ? 5 : 1,
                  maxLength: isDescription
                      ? widget.descriptionMaxCharacter
                      : widget.regularMaxCharacter,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  inputFormatters: isNumber
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : null,
                  onChanged: widget.onChanged,
                  onTap: widget.onTap,
                  validator: _validate,
                  style: context.b2.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  cursorColor: AppColors.primaryBrown,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: widget.backgroundColor ?? AppColors.white,
                    counterText: '',
                    hintText: widget.hintText,
                    hintStyle: context.b2.copyWith(
                      color: AppColors.lightText,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
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
                            padding: const EdgeInsetsDirectional.only(
                                start: 12),
                            child: SvgPicture.asset(
                              widget.prefixPath!,
                              colorFilter:
                                  ColorFilter.mode(iconColor, BlendMode.srcIn),
                            ),
                          )
                        : null,
                    suffixIcon: widget.showSuffixIcon == false
                        ? null
                        : widget.showSuffixIcon == null
                            ? (isDatePicker
                                ? Padding(
                                    padding: const EdgeInsetsDirectional
                                        .only(
                                      end: 12,
                                    ),
                                    child: SvgPicture.asset(
                                      AssetPaths.calenderIcon,
                                    ),
                                  )
                                : isTimePicker
                                    ? Padding(
                                        padding: const EdgeInsetsDirectional
                                            .only(
                                          end: 12,
                                        ),
                                        child: Icon(
                                          Icons.access_time,
                                          color: iconColor,
                                          size: 20,
                                        ),
                                      )
                                    : buildSuffixIcon(iconColor, isPassword))
                            : (isDatePicker
                                ? Padding(
                                    padding: const EdgeInsetsDirectional
                                        .only(
                                      end: 12,
                                    ),
                                    child: SvgPicture.asset(
                                      AssetPaths.calenderIcon,
                                    ),
                                  )
                                : isTimePicker
                                    ? Padding(
                                        padding: const EdgeInsetsDirectional
                                            .only(
                                          end: 12,
                                        ),
                                        child: Icon(
                                          Icons.access_time,
                                          color: iconColor,
                                          size: 20,
                                        ),
                                      )
                                    : buildSuffixIcon(iconColor, isPassword)),
                    contentPadding: isDescription
                        ? const EdgeInsetsDirectional.only(
                            start: 16, top: 24)
                        : widget.contentPadding ??
                            const EdgeInsetsDirectional.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                  ),
                ),
              ),
            ),
          ),
          if (_errorText != null) ...[
            const SizedBox(height: 6),
            Text(
              _errorText!,
              style: context.b2.copyWith(
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

  Widget? buildSuffixIcon(Color iconColor, bool isPassword) {
    if (widget.suffixPath != null) {
      return SvgPicture.asset(
        widget.suffixPath!,
      );
    } else if (isPassword) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: SvgPicture.asset(
          _obscureText ? AssetPaths.eyeOff : AssetPaths.eye,
        ),
      );
    }
    return null;
  }
}
