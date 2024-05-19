import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_palette.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppPallete.gradient2,
      onPrimary: Colors.black,
      secondary: Color(0xFFD0B797),
      onSecondary: Color(0xffffffff),
      error: Color(0xFF5e162e),
      onError: Color(0xFFf5e9ed),
      background: AppPallete.backgroundColor,
      onBackground: Color(0xFFffffff),
      surface: Colors.black87,
      onSurface: Color(0xFFf0fcf4),
    ),
    
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(
        AppPallete.backgroundColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    ),
  );
}
