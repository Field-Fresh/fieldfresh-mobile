import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FieldFreshFAB extends StatelessWidget {
  final List<FieldFreshFABOption> options;
  final Color backgroundColor;
  final Color overlayColor;
  final Color foregroundColor;
  final IconData icon;
  final IconData activeIcon;

  const FieldFreshFAB(
      {Key key,
      @required this.options,
      this.backgroundColor,
      this.overlayColor,
      this.foregroundColor,
      @required this.icon,
      @required this.activeIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
        marginEnd: 18,
        marginBottom: 20,
        icon: icon,
        activeIcon: activeIcon,
        buttonSize: 56.0,
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: overlayColor,
        overlayOpacity: 0.7,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 8.0,
        shape: CircleBorder(),
        children: options.map((e) {
          return SpeedDialChild(
            child: e.icon,
            backgroundColor: e.backgroundColor,
            label: e.label,
            labelStyle: e.labelStyle,
            onTap: e.onTap,
          );
        }).toList());
  }
}

class FieldFreshFABOption {
  final Icon icon;
  final Color backgroundColor;
  final String label;
  final TextStyle labelStyle;
  final VoidCallback onTap;

  FieldFreshFABOption(
      {this.icon,
      this.backgroundColor,
      this.label,
      this.labelStyle,
      this.onTap});
}
