import 'package:fieldfreshmobile/models/api/product/class_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/product_card_listItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Product prod1 = Product(
    type: 'Red',
    catagory: 'Fruit',
    family: 'Apple',
    classType: ProductClass.A,
    imgUrl: 'https://source.unsplash.com/daily',
    value: 100,
    units: 'lbs');

Product prod2 = Product(
    type: 'Fresh',
    catagory: 'Fruit',
    family: 'Banana',
    classType: ProductClass.B,
    imgUrl: 'https://source.unsplash.com/daily',
    value: 250,
    units: 'lbs');

Product prod3 = Product(
    type: 'Fresh',
    catagory: 'Fruit',
    family: 'Orange',
    classType: ProductClass.C,
    imgUrl: 'https://source.unsplash.com/daily',
    value: 130,
    units: 'lbs');

var someList = [prod1, prod2, prod3];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHomePageHeader2(),
          buildProductCard("What is the market buying?", someList),
          buildProductCard("What is the market selling?", someList),
          buildProductCard("What is in season?", someList)
        ],
      ),
    );
  }
}

//Helper functions

Widget buildProductCard(String stringTitle, List someList) {
  return Container(
    child: Card(
        color: AppTheme.colors.light.secondaryDark,
        elevation: 8,
        margin: EdgeInsets.only(top: 8, left: 6, right: 6),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 6),
                      child: Text(
                        stringTitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 6),
                      child: GestureDetector(
                        child: Text(
                          'View All',
                          style: TextStyle(
                              color: AppTheme.colors.light.primary,
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 160,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: someList.length,
                      itemBuilder: (context, index) {
                        return ProductCardListItem(someList[index]);
                      }),
                ),
              ],
            ),
          ),
        )),
  );
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
  return Container(
    margin: EdgeInsets.only(bottom: 5),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppTheme.colors.light.primary,
              border: Border.all(color: AppTheme.colors.light.primary),
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.only(left: 6, top: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Orders: 10',
              style: TextStyle(color: AppTheme.colors.white),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppTheme.colors.light.primary,
              border: Border.all(color: AppTheme.colors.light.primary),
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.only(right: 6, top: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Matches: 20',
              style: TextStyle(color: AppTheme.colors.white),
            ),
          ),
        )
      ],
    ),
  );
}
