import 'package:activ/constants/asset_paths.dart';
import 'package:activ/constants/export.dart';
import 'package:activ/exports.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      // You can replace this with your actual navigation logic
      context.goNamed(AppRouteNames.introScreen);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // You can customize the background color here
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetPaths.logo,
            ),
          ],
        ),
      ),
    );
  }
}
