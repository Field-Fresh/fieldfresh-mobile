import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  const AppTheme._();

  static const colors = const AppColors();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: colors.light.secondary,
    accentColor: colors.light.accent,
    appBarTheme: AppBarTheme(
      color: colors.light.primary,
      iconTheme: IconThemeData(
        color: colors.white
      )
    ),
    colorScheme: ColorScheme.light(
      primary: colors.light.primary,
      primaryVariant: colors.light.primaryDark,
      secondary: colors.light.secondary,
      onPrimary: colors.light.primary,
      onSecondary: colors.light.secondary,
      secondaryVariant: colors.light.secondaryDark
    )
  );
}