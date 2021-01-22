import 'package:flutter/widgets.dart';

class NoGlowSingleChildScrollView extends StatelessWidget {
  final Widget child;

  const NoGlowSingleChildScrollView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (_) {
        _.disallowGlow();
        return true;
      },
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}