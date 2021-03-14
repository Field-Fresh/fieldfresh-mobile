import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DateRangeFeature extends StatelessWidget {
  final DateTime start;
  final DateTime end;

  const DateRangeFeature(this.start, this.end, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Start of matching",
                    style: TextStyle(
                        color: AppTheme.colors.light.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  Text(
                    DateFormat('MMMM dd, yyyy').format(start.toLocal()),
                    style: TextStyle(
                        color: AppTheme.colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "End of matching",
                    style: TextStyle(
                        color: AppTheme.colors.light.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  Text(
                    DateFormat('MMMM dd, yyyy').format(end.toLocal()),
                    style: TextStyle(
                        color: AppTheme.colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
