import 'package:activ/constants/asset_paths.dart';
import 'package:activ/utils/widgets/core_widgets/app_bar.dart';
import 'package:activ/utils/widgets/core_widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:flutter_svg/svg.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: activAppBar(
        title: 'Chat',
        context: context,
        backgroundColor: AppColors.primaryColor,
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
              'Welcome to Activ Chat',
              style: context.h3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your chat journey starts here',
              style: context.b1,
            ),
          ],
        ),
      ),
    );
  }
}
