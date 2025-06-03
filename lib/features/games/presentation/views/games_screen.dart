import 'package:activ/constants/asset_paths.dart';
import 'package:activ/utils/widgets/core_widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:activ/utils/widgets/core_widgets/app_bar.dart';
import 'package:flutter_svg/svg.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: activAppBar(
        title: 'Games',
        context: context,
        actionWidget: ActivIconButton(
          backgroundColor: Colors.transparent,
          icon: SvgPicture.asset(
            AssetPaths.notificationIcon,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Activ Games',
              style: context.h3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your games journey starts here',
              style: context.b1,
            ),
          ],
        ),
      ),
    );
  }
}
