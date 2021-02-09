import 'package:fieldfreshmobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateBuyOrderPage extends StatefulWidget {
  @override
  _CreateBuyOrderPageState createState() => _CreateBuyOrderPageState();
}

class _CreateBuyOrderPageState extends State<CreateBuyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FieldFreshAppBar(),
      body: Container(
        child: Text('Welcome to the buying form'),
      ),
    );
  }
}
