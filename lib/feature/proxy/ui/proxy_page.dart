import 'package:fieldfreshmobile/feature/proxy/bloc/proxy_page_cubit.dart';
import 'package:fieldfreshmobile/feature/proxy/bloc/states.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/proxy/basic_proxy_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ProxySelectionPage extends StatefulWidget {
  @override
  _ProxySelectionPageState createState() => _ProxySelectionPageState();
}

class _ProxySelectionPageState extends State<ProxySelectionPage> {
  ProxyCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<ProxyCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _cubit,
      builder: (context, state) {
        if (state is Empty) {
          _cubit.loadProxies();
        }

        if (state is Loaded) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                BasicProxyView(proxy: state.defaultProxy),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: FormBuilderDropdown(
                      name: "proxy_selection",
                      items: state.proxies.map((e) => DropdownMenuItem(
                            child: Text(e.name, style: TextStyle(color: AppTheme.colors.light.primary),),
                            onTap: () => onTapDelegate(e),
                          )).toList()),
                )
              ],
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void onTapDelegate(Proxy proxy) {
    _cubit.setDefaultProxy(proxy);
  }
}
