import 'package:enum_to_string/enum_to_string.dart';
import 'package:fieldfreshmobile/feature/orders/summary/order_count/bloc/order_count_badge_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/summary/order_count/bloc/states.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum OrderCountType { PENDING, MATCHED }

const Map<OrderCountType, Status> _typeToStatus = {
  OrderCountType.PENDING: Status.PENDING,
  OrderCountType.MATCHED: Status.MATCHED,
};

class OrderCountBadge extends StatefulWidget {
  final Side side;
  final OrderCountType status;
  final Widget label;

  OrderCountBadge({Key key, this.side, @required this.status, this.label})
      : super(key: key);

  @override
  _OrderCountBadgeState createState() =>
      _OrderCountBadgeState(this.side, this.status, this.label);
}

class _OrderCountBadgeState extends State<OrderCountBadge> {
  final Side _side;
  final OrderCountType _status;
  final Widget label;
  OrderCountCubit _cubit;

  _OrderCountBadgeState(this._side, this._status, this.label);

  @override
  void initState() {
    super.initState();
    _cubit = sl<OrderCountCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _cubit,
      builder: (context, state) {
        Widget _label = formatLabel(label);

        if (state is OrderCountStateEmpty) {
          _cubit.loadData(_side, _typeToStatus[_status]);
        }

        if (state is Loaded) {
          return _buildContent(_label,
              content: Text(
                state.orderCount.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ));
        }

        if (state is Error) {
          return _buildContent(Text(
            "Unable to load data",
            style: TextStyle(fontWeight: FontWeight.bold),
          ));
        }

        return _buildContent(_label,
            content: Container(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(
                  backgroundColor: AppTheme.colors.white,
                )));
      },
    );
  }

  Container _buildContent(Widget _label, {Widget content}) => Container(
        decoration: BoxDecoration(
            color: AppTheme.colors.light.primary,
            border: Border.all(color: AppTheme.colors.light.primary),
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.only(left: 6, top: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _label,
              if (content != null)
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: content,
                )
            ],
          ),
        ),
      );

  Widget formatLabel(Widget label) {
    if (label == null) {
      var sideString = EnumToString.convertToString(_side);
      return Text(
        '${EnumToString.convertToString(_status)}${sideString != null ? " $sideString" : ""} Orders',
        style: TextStyle(color: AppTheme.colors.white),
      );
    }
    return label;
  }
}
