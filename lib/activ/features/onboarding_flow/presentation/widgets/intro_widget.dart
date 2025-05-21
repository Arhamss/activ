import 'package:activ/constants/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({
    required this.imagePath,
    required this.title,
    required this.description,
    super.key,
  });
  final String imagePath;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          const Spacer(),
          SvgPicture.asset(imagePath),
          const Spacer(),
          Text(
            textAlign: TextAlign.center,
            title,
            style: context.h1.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: context.t1.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
