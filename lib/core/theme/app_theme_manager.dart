import 'package:evently_app_c13_mon_7pm/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

abstract class AppThemeManager {
  static ThemeData lightThemeData = ThemeData(
    scaffoldBackgroundColor: ColorPalette.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: ColorPalette.primaryColor,
        ),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: ColorPalette.primaryColor,
        )),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontFamily: "Popines",
        fontWeight: FontWeight.w700,
      ),
    ),
  );
  static ThemeData darkThemeData = ThemeData(
    scaffoldBackgroundColor: ColorPalette.secondaryDarkColor,
  );
}
