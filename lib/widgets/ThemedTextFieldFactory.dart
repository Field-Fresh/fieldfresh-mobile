import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum ValidationType { email, required }

class ThemedTextField extends StatelessWidget {
  final String label;
  final ValidationType validationType;
  final String helperText;
  final double edgeRadius;
  final bool hideCounter;
  final bool obscureText;
  final TextInputType type;
  final int maxLength;
  final int maxLines;
  final String initialValue;

  const ThemedTextField(this.label,
      {Key key,
        this.validationType,
        this.helperText,
        this.edgeRadius,
        this.maxLength,
        this.maxLines,
        this.initialValue,
        this.type = TextInputType.text,
        this.obscureText = false,
        this.hideCounter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormBuilderTextField(
        name: label,
        style:
        TextStyle(fontSize: 18, color: AppTheme.colors.light.primaryDark),
        validator: getValidation(context),
        obscureText: obscureText,
        initialValue: initialValue,
        maxLines: maxLines ?? 1,
        keyboardType: type,
        maxLength: maxLength,
        decoration: InputDecoration(
          helperMaxLines: 2,
          filled: true,
          helperText: helperText,
          helperStyle: TextStyle(color: AppTheme.colors.light.primary),
          fillColor: AppTheme.colors.white,
          hintStyle: TextStyle(color: AppTheme.colors.light.secondary),
          hintText: label,
          counterStyle: TextStyle(
              color: AppTheme.colors.white.withOpacity(hideCounter ? 0 : 1)),
        ),
      ),
    );
  }

  FormFieldValidator<String> getValidation(context) {
    switch (validationType) {
      case ValidationType.email:
        return FormBuilderValidators.compose([
          FormBuilderValidators.email(context),
          FormBuilderValidators.required(context),
        ]);
        break;
      case ValidationType.required:
        return FormBuilderValidators.required(context);
        break;
    }
  }
}

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
