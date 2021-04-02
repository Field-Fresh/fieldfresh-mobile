import 'package:fieldfreshmobile/models/address_components.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/ThemedTextFieldFactory.dart';
import 'package:fieldfreshmobile/widgets/step_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';

typedef SaveProxyListener = void Function(AddressComponents components,
    LatLng latLng, String name, String description);

class ProxyDetailsStepView extends StatefulWidget {
  final SaveProxyListener listener;
  final Function back;
  final Proxy initialProxy;

  const ProxyDetailsStepView(
      {Key key, this.listener, this.back, this.initialProxy})
      : super(key: key);

  @override
  _ProxyDetailsStepViewState createState() =>
      _ProxyDetailsStepViewState(listener, back, initialProxy);
}

class _ProxyDetailsStepViewState extends State<ProxyDetailsStepView> {
  final _formKey = GlobalKey<FormBuilderState>();
  final SaveProxyListener listener;
  final Function back;
  final Proxy initialProxy;

  bool isBusiness = false;
  AddressComponents components;
  LatLng latLng;

  _ProxyDetailsStepViewState(this.listener, this.back, this.initialProxy);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_logoContainer(), _infoImageContainer(), _formContent()],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Container _logoContainer() => Container(
        child: SvgPicture.asset(
          'graphics/app-logo-small.svg',
          height: 100,
          fit: BoxFit.fitWidth,
        ),
      );

  Container _infoImageContainer() => Container(
        child: SvgPicture.asset(
          'graphics/proxy-details-message-large.svg',
          height: 250,
          fit: BoxFit.fitHeight,
        ),
      );

  Container _businessToggle({toggled = false}) => Container(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Are you a business?",
                style: TextStyle(
                    color: AppTheme.colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Switch(
                onChanged: (bool value) {
                  setState(() {
                    isBusiness = value;
                  });
                },
                value: isBusiness,
              ),
            ],
          ),
        ),
      );

  Container _formContent() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 18),
                child: SearchMapPlaceWidget(
                  onSearch: (place) async {
                    _locationSearchDelegate(place);
                  },
                  iconColor: AppTheme.colors.light.primary,
                  apiKey: "AIzaSyBIZQuRKHy2TvmE9ul0ulTBV_PgRLEo9Nw",
                  placeType: PlaceType.address,
                  placeholder: "Please enter your location...",
                  onSelected: (place) async {
                    _locationSearchDelegate(place);
                  },
                )),
            _businessToggle(toggled: isBusiness),
            if (isBusiness)
              FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 18),
                          child: ThemedTextField("Business Name",
                              helperText:
                                  "Enter a display name for your business")),
                      Container(
                          margin: EdgeInsets.only(bottom: 18),
                          child: ThemedTextField("Business Description",
                              maxLength: 250,
                              maxLines: 4,
                              helperText: "What does your business do?")),
                    ],
                  )),
            StepNavBar(nextCallback: _save, backCallback: back)
          ],
        ),
      ),
    );
  }

  void _save() {
    var name;
    var desc;
    if (_formKey.currentState != null) {
      _formKey.currentState.save();
      if (_formKey.currentState.validate()) {
        name = _formKey.currentState.value['Business Name'];
        desc = _formKey.currentState.value['Business Description'];
      }
    }
    listener.call(components, latLng, name, desc);
  }

  void _locationSearchDelegate(Place place) async {
    var geo = await place.geolocation;
    LatLng coord = geo.coordinates;
    if (coord == null) {
      return;
    }
    AddressComponents comp = AddressComponents.fromGeolocation(geo);
    setState(() {
      latLng = LatLng(coord.longitude, coord.latitude);
      this.components = comp;
    });
  }
}
