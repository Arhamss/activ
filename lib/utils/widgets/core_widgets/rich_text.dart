import 'package:flutter/gestures.dart';
import 'package:activ/exports.dart';

class ActivRichText extends StatelessWidget {
  const ActivRichText({
    required this.textBefore,
    required this.richText,
    required this.textAfter,
    super.key,
    this.normalTextStyle,
    this.richTextStyle,
    this.richTextColor,
    this.onRichTextTap,
    this.textAlign = TextAlign.center,
    this.noSpace = false,
    this.richTextDecoration,
  });

  final TextStyle? normalTextStyle;
  final TextStyle? richTextStyle;
  final bool noSpace;
  final String textBefore;
  final String textAfter;
  final String richText;
  final Color? richTextColor;
  final VoidCallback? onRichTextTap;
  final TextAlign textAlign;
  final TextDecoration? richTextDecoration;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        text: textBefore,
        style: normalTextStyle ??
            context.b2.copyWith(
              color: AppColors.lightText,
              fontWeight: FontWeight.bold,
            ),
        children: [
          TextSpan(
            text: noSpace ? richText : ' $richText ',
            style: richTextStyle ??
                context.b2.copyWith(
                  color: richTextColor ?? AppColors.primaryOrange,
                  fontWeight: FontWeight.bold,
                  decoration: richTextDecoration,
                ),
            recognizer: TapGestureRecognizer()..onTap = onRichTextTap,
          ),
          TextSpan(
            text: textAfter,
            style: normalTextStyle ??
                context.b2.copyWith(
                  color: AppColors.lightText,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
