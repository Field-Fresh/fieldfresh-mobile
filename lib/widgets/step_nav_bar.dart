import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef NextCallback = void Function();
typedef BackCallback = void Function();

class StepNavBar extends StatelessWidget {
  final NextCallback nextCallback;
  final BackCallback backCallback;

  const StepNavBar({
    Key key,
    @required this.nextCallback,
    @required this.backCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorBack = AppTheme.colors.white.withOpacity(0.7);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton.icon(
            onPressed: () {
              backCallback.call();
            },
            icon: Icon(Icons.arrow_back, color: colorBack,),
            label: Text("Back", style: TextStyle(color: colorBack),)),
        ThemedButtonFactory.create(100, 40, 18, "Next", () {
          nextCallback.call();
        })
      ],
    );
  }
}
