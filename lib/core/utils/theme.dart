import 'package:cart/core/utils/colors.dart';
import 'package:flutter/material.dart';

class ThemeUtil {
  static final themeData = ThemeData(
    primaryColor: ColorsUtil.primaryColor,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorsUtil.primaryColor,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorsUtil.primaryColor,
      secondary: ColorsUtil.secondaryColor,
    ),
  );
}
