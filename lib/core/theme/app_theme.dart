import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_app/core/theme/app_palette.dart';

class AppTheme {
  static _border([Color color = AppPalette.whiteColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.primaryColor,
      brightness: Brightness.dark,
      primary: AppPalette.primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.transparent,
      elevation: 0,
    ),
    textTheme: GoogleFonts.montserratTextTheme().apply(
      bodyColor: AppPalette.whiteColor,
      displayColor: AppPalette.whiteColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      border: _border(AppPalette.transparent),
      filled: true,
      fillColor: AppPalette.fillColor,
    ),
  );
}
