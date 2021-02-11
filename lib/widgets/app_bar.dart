import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FieldFreshAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  FieldFreshAppBar({
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(color: AppTheme.colors.light.primary),
        backgroundColor: AppTheme.colors.light.secondary,
        centerTitle: true,
        title: SvgPicture.asset(
          'graphics/app-logo-small.svg',
          width: 50,
          height: 50,
        ));
  }
}
