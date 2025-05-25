import 'dart:io';

import 'package:activ/exports.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ActivImagePicker extends StatelessWidget {
  const ActivImagePicker({
    required this.onButtonPressed,
    required this.imagePath,
    super.key,
  });

  final VoidCallback onButtonPressed;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onButtonPressed,
      icon: imagePath == null || (imagePath ?? '').isEmpty
          ? SvgPicture.asset(AssetPaths.galleryIcon)
          : ClipOval(
              child: _getImageWidget(imagePath!),
            ),
      padding: EdgeInsets.all(
        imagePath == null || (imagePath ?? '').isEmpty ? 50 : 0,
      ),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.greyShade4,
        shape: const CircleBorder(),
        side: const BorderSide(
          color: AppColors.greyShade6,
        ),
      ),
    );
  }

  Widget _getImageWidget(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        height: 130.03,
        width: 130.03,
        imagePath,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        height: 130.03,
        width: 130.03,
        fit: BoxFit.cover,
        File(imagePath.replaceFirst('file://', '')),
      );
    }
  }
}
