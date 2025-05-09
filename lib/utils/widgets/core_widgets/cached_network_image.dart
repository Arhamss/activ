import 'package:cached_network_image/cached_network_image.dart';
import 'package:activ/exports.dart';

class ActivCachedImageWidget extends StatelessWidget {
  const ActivCachedImageWidget({
    required this.imageUrl,
    this.placeHolder = '',
    super.key,
    this.width,
    this.height,
    this.borderRadius = 0.0,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final String placeHolder;
  final double borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => const Center(
          child: LoadingWidget(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          placeHolder,
          width: width,
          height: height,
          fit: fit,
        ),
      ),
    );
  }
}
