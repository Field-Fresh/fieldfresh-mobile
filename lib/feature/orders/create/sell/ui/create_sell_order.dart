import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/app_bar.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CreateSellOrderPage extends StatefulWidget {
  @override
  _CreateSellOrderPageState createState() => _CreateSellOrderPageState();
}

class _CreateSellOrderPageState extends State<CreateSellOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FieldFreshAppBar(),
      body: NoGlowSingleChildScrollView(
          child: Column(
        children: [
          createImageHolder(),
          createSearchableDropDown(label: 'Product Catagory'),
          createSearchableDropDown(label: 'Product Family'),
          createSearchableDropDown(label: 'Product Type'),
          createDateField(label: 'Earliest Availability', context: context),
          createRangeSlider(label: 'Requested Inventory (lbs)'),
          createSlider(label: 'Minimum Price Per Unit (\$/lbs)'),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.colors.light.primary,
                  border: Border.all(color: AppTheme.colors.light.primary),
                  borderRadius: BorderRadius.circular(40)),
              margin: EdgeInsets.only(top: 30, bottom: 30),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Place Sell Order',
                  style: TextStyle(
                      color: AppTheme.colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

//Add functionality to accept a list<String> and convert it into List<DropdownMenuItem>
Widget createSearchableDropDown({label}) {
  return Container(
    height: 50,
    width: double.infinity,
    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppTheme.colors.light.secondaryLight),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            label,
            style: TextStyle(fontSize: 16, color: AppTheme.colors.white),
          ),
          margin: EdgeInsets.only(left: 20),
        ),
        SearchableDropdown(
          style: TextStyle(color: AppTheme.colors.light.secondaryDark),
          items: [
            DropdownMenuItem(child: Text('Test')),
            DropdownMenuItem(child: Text('Test')),
            DropdownMenuItem(child: Text('Test'))
          ],
          onChanged: (value) {},
          menuBackgroundColor: AppTheme.colors.white,
          iconEnabledColor: AppTheme.colors.light.primary,
          underline: Container(),
        ),
      ],
    ),
  );
}

Widget createDateField({label, context}) {
  return GestureDetector(
    child: Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppTheme.colors.light.secondaryLight),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(label,
                  style: TextStyle(fontSize: 16, color: AppTheme.colors.white)),
              margin: EdgeInsets.only(left: 20),
            ),
            Container(
              margin: EdgeInsets.only(right: 13),
              child: Icon(
                Icons.calendar_today,
                color: AppTheme.colors.light.primary,
                size: 20,
              ),
            )
          ],
        ),
      ),
    ),
    onTap: () {
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2022));
    },
  );
}

Widget createRangeSlider({label}) {
  return Container(
    height: 120,
    width: double.infinity,
    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppTheme.colors.light.secondaryLight),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(label,
              style: TextStyle(fontSize: 16, color: AppTheme.colors.white)),
          margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
        ),
        Container(
          child: RangeSlider(
            min: 0,
            max: 100,
            activeColor: AppTheme.colors.light.primary,
            inactiveColor: AppTheme.colors.light.secondary,
            values: RangeValues(10, 70),
            onChanged: (value) {},
          ),
        )
      ],
    ),
  );
}

Widget createSlider({label}) {
  return Container(
    height: 120,
    width: double.infinity,
    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppTheme.colors.light.secondaryLight),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(label,
              style: TextStyle(fontSize: 16, color: AppTheme.colors.white)),
          margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
        ),
        Container(
          child: Slider(
            min: 0,
            max: 100,
            activeColor: AppTheme.colors.light.primary,
            inactiveColor: AppTheme.colors.light.secondary,
            value: 10,
            onChanged: (value) {},
          ),
        )
      ],
    ),
  );
}

Widget createToggleSwitch({String label, List<String> list}) {
  return Container(
    height: 100,
    width: double.infinity,
    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppTheme.colors.light.secondaryLight),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(label,
              style: TextStyle(fontSize: 16, color: AppTheme.colors.white)),
          margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
        ),
        Container(
          child: Center(
            child: ToggleSwitch(
              minHeight: 30,
              minWidth: 80,
              initialLabelIndex: 0,
              labels: list,
              activeBgColor: AppTheme.colors.light.primary,
              inactiveBgColor: AppTheme.colors.light.secondaryDark,
              inactiveFgColor: AppTheme.colors.light.secondaryLight,
              onToggle: (index) {},
            ),
          ),
        ),
      ],
    ),
  );
}

Widget createImageHolder() {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    height: 185,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppTheme.colors.light.primary),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.network(
          'https://source.unsplash.com/daily',
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
        ),
        Container(
            margin: EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              'Click to Change Image',
              style: TextStyle(color: AppTheme.colors.white, fontSize: 14),
            )),
      ],
    ),
  );
}