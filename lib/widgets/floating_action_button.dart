import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FieldFreshFAB extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  FieldFreshFAB({
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print("Hello!");
      },
      tooltip: 'Menu',
      child: Icon(Icons.add),
      backgroundColor: AppTheme.colors.light.primary,
      foregroundColor: AppTheme.colors.white,
    );
  }
}
