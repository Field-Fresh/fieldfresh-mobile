import 'package:fieldfreshmobile/feature/home/bloc/side_type.dart';
import 'package:fieldfreshmobile/feature/orders/summary/order_count/ui/order_count_badge.dart';
import 'package:fieldfreshmobile/feature/products/pending/ui/pending_products.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/floating_action_button.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHomePageHeader2(),
          PendingProductList(side: Side.BUY),
          PendingProductList(side: Side.SELL),
        ],
      ),
    );
  }
}


Widget buildHomePageHeader() {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        margin: EdgeInsets.only(left: 6, top: 10),
        color: AppTheme.colors.white.withOpacity(0.3),
        child: Row(
          children: [
            SvgPicture.asset(
              'graphics/matches_logo_home.svg',
              width: 50,
              height: 50,
            ),
            Text("10", style: TextStyle(color: Colors.white, fontSize: 25)),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(right: 6, top: 10),
        color: AppTheme.colors.white.withOpacity(0.3),
        child: Row(
          children: [
            SvgPicture.asset(
              'graphics/orders_logo_home.svg',
              width: 50,
              height: 50,
            ),
            Text("10", style: TextStyle(color: Colors.white, fontSize: 25)),
          ],
        ),
      ),
    ],
  );
}

Widget buildHomePageHeader2() {
  var labelStyle = TextStyle(color: AppTheme.colors.white, fontWeight: FontWeight.bold);
  return Container(
    margin: EdgeInsets.only(bottom: 5),
    child: Container(
      height: 50,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          OrderCountBadge(side: Side.SELL, status: OrderCountType.PENDING, label: Text("Sell Orders", style: labelStyle,),),
          OrderCountBadge(side: Side.BUY, status: OrderCountType.PENDING, label: Text("Buy Orders", style: labelStyle,),),
          OrderCountBadge(status: OrderCountType.MATCHED, label: Text("Match Orders", style: labelStyle,),),
        ],
      ),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FieldFreshFAB(
        activeIcon: Icons.remove,
        icon: Icons.menu,
        foregroundColor: AppTheme.colors.white,
        backgroundColor: AppTheme.colors.light.primary,
        options: [
          FieldFreshFABOption(
              label: "Buy",
              icon: Icon(Icons.shopping_cart, color: AppTheme.colors.white,),
              labelStyle: TextStyle(fontSize: 18),
              backgroundColor: AppTheme.colors.light.primary),
          FieldFreshFABOption(
              label: "Sell",
              icon: Icon(Icons.attach_money, color: AppTheme.colors.white,),
              labelStyle: TextStyle(fontSize: 18),
              backgroundColor: AppTheme.colors.light.primary),
          FieldFreshFABOption(
              label: "Reorder",
              icon: Icon(Icons.history, color: AppTheme.colors.white,),
              labelStyle: TextStyle(fontSize: 18),
              backgroundColor: AppTheme.colors.light.primary),
        ],
      ),
      body: NoGlowSingleChildScrollView(child: HomePage()),
    );
  }
}
