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
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 6),
                child: Text(
                  'What is the market buying?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 6),
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

          //This is where the selling begins.

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 6),
                child: Text(
                  'What is the market selling?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 6),
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

          //This is where the stats and logos starts.
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 6),
            child: Text(
              'My Orders...',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),

          //logo container

          Container(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 6, top: 10),
                      color: AppTheme.colors.white.withOpacity(0.3),
                      child: SvgPicture.asset(
                        'graphics/matches_logo_home.svg',
                        width: 75,
                        height: 75,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text("10",
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 6, top: 10),
                      color: AppTheme.colors.white.withOpacity(0.3),
                      child: SvgPicture.asset(
                        'graphics/orders_logo_home.svg',
                        width: 75,
                        height: 75,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text("10",
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
