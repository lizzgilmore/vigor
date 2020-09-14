import 'package:flutter/material.dart';

import 'text_theme.dart';

abstract class ThemeClass {
  static ThemeData light() => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: AppColors.primaryLight,
        accentColor: AppColors.secondaryLight,
        backgroundColor: AppColors.backgroundLight,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        disabledColor: AppColors.disabledLight,
        textTheme: MyTextTheme.buildLightTextTheme(),
      );

  static ThemeData dark() => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryDark,
        accentColor: AppColors.secondaryDark,
        disabledColor: AppColors.disabledDark,
        backgroundColor: AppColors.backgroundDark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        textTheme: MyTextTheme.buildDarkTextTheme(),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.blue, width: 24.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
      );
}

class AppColors {
  // Light theme
  static const Color primaryLight = Color(0xFF2D9CDB);
  static const Color secondaryLight = Color(0xFFF2C94C);
  static const Color disabledLight = Colors.white38;
  static const Color backgroundLight = Colors.white;
  static const Color textDark = Color(0xFF000000);
  // Dark theme  // todo: replace
  static const Color primaryDark = Color(0xFF2D9CDB);
  static const Color secondaryDark = Color(0xFFF2C94C);
  static const Color disabledDark = Colors.white38;
  static const Color backgroundDark = Colors.white;
  static const Color textLight = gray6;
  // Multi-theme
  static const Color gray5 = Color(0xFFE0E0E0);
  static const Color gray6 = Color(0xFFF2F2F2);
}
