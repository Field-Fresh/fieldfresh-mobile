import 'package:fieldfreshmobile/feature/drawer/bloc/dashboard_bloc.dart';
import 'package:fieldfreshmobile/feature/drawer/bloc/dashboard_state.dart';
import 'package:fieldfreshmobile/feature/drawer/event/events.dart';
import 'package:fieldfreshmobile/feature/drawer/state/states.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/util/user_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavDrawerWidget extends StatelessWidget {
  final List<_NavigationItem> _listItems = [
    _NavigationItem(true, NavItem.profile, "Profile", null),
    _NavigationItem(false, NavItem.home, "Home", Icons.trending_up),
    _NavigationItem(false, NavItem.proxy, "Proxies", Icons.store),
    _NavigationItem(false, NavItem.profile, "Profile", Icons.person),
    _NavigationItem(false, NavItem.active_orders, "My Orders", Icons.toll),
    _NavigationItem(false, NavItem.matches, "My Matches", Icons.check),
    _NavigationItem(false, NavItem.history, "Order History", Icons.history),
  ];

  @override
  Widget build(BuildContext context) {
    User user = UserSingleton().getUser();
    return BlocBuilder(
      bloc: BlocProvider.of<NavDrawerBloc>(context),
      builder: (context, NavDrawerState state) {
        return Drawer(
            child: Container(
                color: AppTheme.colors.white,
                child: ListView.builder(
                    itemCount: _listItems.length,
                    itemBuilder: (context, pos) {
                      return _buildItem(context, _listItems[pos], state, user);
                    })));
      },
    );
  }

  Widget _buildItem(BuildContext context, _NavigationItem data,
          NavDrawerState state, User user) =>
      data.header ? _makeHeaderItem(context, user) : _makeListItem(data, state);

  Widget _makeHeaderItem(context, user) => GestureDetector(
        onTap: () {
          _handleItemClick(context, NavItem.profile);
        },
        child: UserAccountsDrawerHeader(
          accountName: Text(user?.firstName ?? "User",
              style: TextStyle(color: AppTheme.colors.light.secondaryDark)),
          accountEmail: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (user?.lastName != null)
                  Text(user.lastName,
                      style: TextStyle(
                          color: AppTheme.colors.light.secondaryDark)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/");
                  },
                  child: Container(
                      padding: EdgeInsets.only(top: 6),
                      child: Text("Log Out",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppTheme.colors.light.secondaryDark))),
                ),
              ]),
          decoration: BoxDecoration(color: AppTheme.colors.white),
          currentAccountPicture: CircleAvatar(
            backgroundColor: AppTheme.colors.light.secondary.withOpacity(0.9),
            foregroundColor: AppTheme.colors.light.primary,
            child: Icon(
              Icons.person,
              size: 50,
            ),
          ),
        ),
      );

  Widget _makeListItem(_NavigationItem data, NavDrawerSelectedState state) =>
      Column(
        children: [
          Card(
            color: data.item == state.selectedItem
                ? AppTheme.colors.light.primary.withOpacity(0.3)
                : Colors.transparent,
            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
            borderOnForeground: true,
            elevation: 0,
            margin: EdgeInsets.zero,
            child: Builder(
              builder: (BuildContext context) => ListTile(
                title: Text(
                  data.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: data.item == state.selectedItem
                        ? AppTheme.colors.light.secondary
                        : AppTheme.colors.light.secondary,
                  ),
                ),
                leading: Icon(
                  data.icon,
                  color: data.item == state.selectedItem
                      ? AppTheme.colors.light.secondary
                      : AppTheme.colors.light.secondary,
                ),
                onTap: () {
                  _handleItemClick(context, data.item);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(height: 1, color: AppTheme.colors.light.secondary.withOpacity(0.7),),
          )
        ],
      );

  void _handleItemClick(BuildContext context, NavItem item) {
    BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }
}

class _NavigationItem {
  final bool header;
  final NavItem item;
  final String title;
  final IconData icon;

  _NavigationItem(this.header, this.item, this.title, this.icon);
}
