import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemedTextFieldFactory {
  static const double edgeRadius = 4.0;

  static TextField create(var controller, var label,
      {TextInputType type = TextInputType.text,
      maxLength,
      maxLines,
      bool hideCounter = false,
      helperText}) {
    return TextField(
      controller: controller,
      keyboardType: type,
      maxLength: maxLength,
      maxLines: maxLines,
      cursorColor: AppTheme.colors.light.secondary,
      style: TextStyle(fontSize: 18, color: AppTheme.colors.light.primaryDark),
      decoration: InputDecoration(
        helperMaxLines: 2,
        filled: true,
        helperText: helperText,
        helperStyle: TextStyle(color: AppTheme.colors.light.primary),
        fillColor: AppTheme.colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(edgeRadius)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(edgeRadius)),
            borderSide: BorderSide.none),
        labelStyle: TextStyle(
          color: AppTheme.colors.light.secondary,
        ),
        counterStyle: TextStyle(
            color: AppTheme.colors.white.withOpacity(hideCounter ? 0 : 1)),
        hintStyle: TextStyle(color: AppTheme.colors.light.secondary),
        hintText: label,
      ),
    );
  }

  static TextField createForSensitive(var controller, var label) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.colors.white,
          hoverColor: AppTheme.colors.light.secondary,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(edgeRadius)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(edgeRadius)),
              borderSide: BorderSide.none),
          labelStyle: TextStyle(
            color: AppTheme.colors.light.secondary,
            fontWeight: FontWeight.bold,
          ),
          hintStyle: TextStyle(color: AppTheme.colors.light.secondary),
          hintText: label),
    );
  }
}
