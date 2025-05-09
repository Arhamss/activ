import 'package:flutter/cupertino.dart';

class WaveClippers {
  static CustomClipper<Path> get top => _TopWaveClipper();

  static CustomClipper<Path> get bottom => _BottomWaveClipper();
}

class _TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 80)
      ..quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        size.height - 80,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 80)
      ..quadraticBezierTo(
        size.width / 2,
        0,
        size.width,
        80,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
