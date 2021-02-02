import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemedButtonFactory {
  static Widget create(
      final double width,
      final double height,
      final double fontSize,
      final String text,
      final VoidCallback onPressed) {
    return Container(
      width: width,
      height: height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Text(
          text,
          style: TextStyle(
              color: AppTheme.colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize),
        ),
        color: AppTheme.colors.light.primary,
        onPressed: onPressed,
      ),
    );
  }

}
