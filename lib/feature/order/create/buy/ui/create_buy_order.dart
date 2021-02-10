import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/app_bar.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CreateBuyOrderPage extends StatefulWidget {
  @override
  _CreateBuyOrderPageState createState() => _CreateBuyOrderPageState();
}

class _CreateBuyOrderPageState extends State<CreateBuyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FieldFreshAppBar(),
      body: NoGlowSingleChildScrollView(
          child: Column(
        children: [
          createSearchableDropDown(label: 'Product Catagory'),
          createSearchableDropDown(label: 'Product Family'),
          createSearchableDropDown(label: 'Product Type'),
          createDateField(label: 'Earliest Recieving Date', context: context),
          createRangeSlider(label: 'Requested Inventory (lbs)'),
          createSlider(label: 'Maximum Price Per Unit (\$/lbs)'),
          createToggleSwitch(label: 'Status', list: ['Active', 'Inactive']),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.colors.light.primary,
                  border: Border.all(color: AppTheme.colors.light.primary),
                  borderRadius: BorderRadius.circular(40)),
              margin: EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Place Buy Order',
                  style: TextStyle(color: AppTheme.colors.white),
                ),
              ),
            ),
          )
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
    margin: EdgeInsets.only(left: 6, right: 6, top: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4), color: AppTheme.colors.white),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(label),
          margin: EdgeInsets.only(left: 20),
        ),
        SearchableDropdown(
          style: TextStyle(color: AppTheme.colors.light.secondaryDark),
          items: [
            DropdownMenuItem(child: Text('Test')),
            DropdownMenuItem(child: Text('Test')),
            DropdownMenuItem(child: Text('Test'))
          ],
          onChanged: () {},
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
      margin: EdgeInsets.only(left: 6, right: 6, top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: AppTheme.colors.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(label),
              margin: EdgeInsets.only(left: 20),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
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
    margin: EdgeInsets.only(left: 6, right: 6, top: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4), color: AppTheme.colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(label),
          margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
        ),
        Container(
          child: RangeSlider(
            min: 0,
            max: 100,
            activeColor: AppTheme.colors.light.primary,
            inactiveColor: AppTheme.colors.light.secondary,
            values: RangeValues(1, 100),
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
    margin: EdgeInsets.only(left: 6, right: 6, top: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4), color: AppTheme.colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(label),
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
    margin: EdgeInsets.only(left: 6, right: 6, top: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4), color: AppTheme.colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(label),
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
              onToggle: (index) {},
            ),
          ),
        ),
      ],
    ),
  );
}
