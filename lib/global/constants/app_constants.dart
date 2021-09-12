// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class ColorConstants {
  static const LinearGradient kPrimaryGradientColor = LinearGradient(
    // begin: Alignment.centerLeft,
    // end: Alignment.centerRight,
    colors: [Color(0xFF88D3F6), Color(0xFF3783F5)],
  );

  static const Color kPrimaryColor = Color(0xFFFF7643);
  static const Color kPrimaryLightColor = Color(0xFFFFFFFF);
  static const Color kSecondaryColor = Color(0xFF347AF0);
  static const Color kBackgroundColor = Color(0xFFEDF1F9);
  static const Color kTextColor = Color(0xFF0D1F3C);
  static const List<Color> kListColorPickup = [
    Color(0xFF6074F9),
    Color(0xFFE42B6A),
    Color(0xFF5ABB56),
    Color(0xFF3D3A62),
    Color(0xFFF4CA8F),
  ];
}

class AppConstants {
  static const Duration kAnimationDuration = Duration(milliseconds: 200);
}
