import 'package:activ/exports.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    required this.image,
    required this.text,
    this.subtitle,
    this.onButtonPressed,
    this.imageSize,
    this.spacing = 24.0,
    this.buttonColor,
    this.imageWidget,
    this.imageAlignment = Alignment.center,
    super.key,
  });

  final String? image; // Image asset path
  final Widget? imageWidget; // Alternative to using asset path
  final String text;
  final String? subtitle;
  final VoidCallback? onButtonPressed;
  final double? imageSize; // Made nullable to calculate dynamically
  final double spacing;
  final Color? buttonColor;
  final Alignment imageAlignment;

  @override
  Widget build(BuildContext context) {
    final calculatedImageSize =
        imageSize ?? MediaQuery.of(context).size.width * 0.75;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (imageWidget != null)
          imageWidget!
        else if (image != null)
          Align(
            alignment: imageAlignment,
            child: image!.endsWith('.svg')
                ? SvgPicture.asset(
                    image!,
                    height: calculatedImageSize,
                    width: calculatedImageSize,
                  )
                : Image.asset(
                    image!,
                    height: calculatedImageSize,
                    width: calculatedImageSize,
                  ),
          ),
        SizedBox(height: spacing),
        Text(
          text,
          style: context.b1.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 22,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            style: context.b1.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ],
    );
  }
}
