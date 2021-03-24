import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BasicProxyView extends StatelessWidget {

  final Proxy proxy;

  const BasicProxyView({Key key, this.proxy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              proxy.name,
              style: TextStyle(
                  color: AppTheme.colors.light.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                proxy.streetAddress,
                style: TextStyle(
                    color: AppTheme.colors.light.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            Text(
              "${proxy.city}, ${proxy.province} ${proxy.postalCode}",
              style: TextStyle(
                  color: AppTheme.colors.light.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                "${proxy.country}",
                style: TextStyle(
                    color: AppTheme.colors.light.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
