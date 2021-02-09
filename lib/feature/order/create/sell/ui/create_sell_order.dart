import 'package:fieldfreshmobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateSellOrderPage extends StatefulWidget {
  @override
  _CreateSellOrderPageState createState() => _CreateSellOrderPageState();
}

class _CreateSellOrderPageState extends State<CreateSellOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FieldFreshAppBar(),
      body: Container(
        child: Text('Welcome to the selling form'),
      ),
    );
  }
}
