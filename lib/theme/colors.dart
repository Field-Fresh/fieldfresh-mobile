import 'dart:ui';

class AppColors {
  final light = const LightColors();

  final white = const Color(0xffffffff);

  const AppColors();
}

class LightColors {
    final Color primary = const Color(0xff56ad41);
    final Color primaryDark = const Color(0xf01e7d0f);
    final Color primaryLight = const Color(0xf01e7d0f);
    final Color accent = const Color(0xff56ad41);
    final Color secondary = const Color(0xff3c3d33);
    final Color secondaryLight = const Color(0xf066675c);
    final Color secondaryDark = const Color(0xf016170c);
    final Color errorRed = const Color(0xffD03636);
    const LightColors();
}
