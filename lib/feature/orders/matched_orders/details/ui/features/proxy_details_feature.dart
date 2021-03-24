import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/proxy/basic_proxy_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProxyDetailsFeature extends StatelessWidget {
  final Proxy proxy;
  final Side side;

  const ProxyDetailsFeature({Key key, this.proxy, this.side}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(bottom: 12), child: getTitle()),
        BasicProxyView(proxy: proxy,),
      ],
    );
  }

  Text getTitle() => Text(
        side == Side.SELL ? "Matched Buyer" : "Matched Seller",
        style: TextStyle(
            color: AppTheme.colors.light.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold),
      );
}
