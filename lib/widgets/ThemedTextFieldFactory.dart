import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemedTextFieldFactory {
  static TextField create(var controller, var label) {
    return TextField(
      controller: controller,
      cursorColor: AppTheme.colors.light.secondary,
      style: TextStyle(fontSize: 18, color: AppTheme.colors.light.primaryDark),
      decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.colors.white,
          hoverColor: AppTheme.colors.light.secondary,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.colors.light.secondary)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.colors.light.secondary)),
          labelStyle: TextStyle(
            color: AppTheme.colors.light.secondary,
            fontWeight: FontWeight.bold,
          ),
          hintStyle: TextStyle(color: AppTheme.colors.light.secondary),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: label),
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
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.colors.light.secondary)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.colors.light.secondary)),
          labelStyle: TextStyle(
            color: AppTheme.colors.light.secondary,
            fontWeight: FontWeight.bold,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: label),
    );
  }
}
