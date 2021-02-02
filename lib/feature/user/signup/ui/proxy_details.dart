import 'package:fieldfreshmobile/feature/user/login/ui/login_page.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/event/events.dart';
import 'package:fieldfreshmobile/feature/user/signup/state/states.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/user_verification.dart';
import 'package:fieldfreshmobile/models/address_components.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'package:fieldfreshmobile/widgets/ThemedTextFieldFactory.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';

import '../../../../injection_container.dart';

class ProxyDetailsForm extends StatefulWidget {
  @override
  _ProxyDetailsFormState createState() => _ProxyDetailsFormState();
}

class _ProxyDetailsFormState extends State<ProxyDetailsForm> {
  final _proxyName = TextEditingController();
  final _proxyDescription = TextEditingController();
  UserSignUpBloc _userSignUpBloc;

  @override
  void initState() {
    super.initState();
    _userSignUpBloc = BlocProvider.of<UserSignUpBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignUpBloc, UserSignUpState>(
        bloc: _userSignUpBloc,
        builder: (context, state) {
          if (state is ProxyDetailsSuccessState) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserVerificationScreen()));
            });
          }

          return Column(
            children: [
              _logoContainer(),
              _infoImageContainer(),
              _formContent(state),
              _buttonContainer()
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          );
        });
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
              Text("Are you a business?", style: TextStyle(color: AppTheme.colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
              Switch(
                onChanged: (bool value) {
                  print(value);
                  print(_userSignUpBloc.isBusiness);
                  _userSignUpBloc.add(ProxyDetailsBusinessToggleEvent(value));
                },
                value: _userSignUpBloc.isBusiness,
              ),
            ],
          ),
        ),
      );

  Container _formContent(state) {
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
            _businessToggle(toggled: _userSignUpBloc.isBusiness),
            if (_userSignUpBloc.isBusiness)
              Container(
                  margin: EdgeInsets.only(bottom: 18),
                  child: ThemedTextFieldFactory.create(
                      _proxyName, "Business Name",
                      helperText: "Enter a display name for your business")),
            if (_userSignUpBloc.isBusiness)
              Container(
                  margin: EdgeInsets.only(bottom: 18),
                  child: ThemedTextFieldFactory.create(
                      _proxyDescription, "Business Description",
                      maxLength: 250,
                      maxLines: 4,
                      helperText: "What does your business do?")),
          ],
        ),
      ),
    );
  }

  Container _nonBusinessDetailsFormContent() => Container(
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
                    placeholder: "Please enter your business location...",
                    onSelected: (place) async {
                      _locationSearchDelegate(place);
                    },
                  )),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 18),
                  child: ThemedTextFieldFactory.create(
                      _proxyName, "Business Name",
                      helperText: "Enter a display name for your business")),
              Container(
                  margin: EdgeInsets.only(bottom: 18),
                  child: ThemedTextFieldFactory.create(
                      _proxyDescription, "Business Description",
                      maxLength: 250,
                      maxLines: 4,
                      helperText: "What does your business do?")),
            ],
          ),
        ),
      );

  Container _buttonContainer() => Container(
        child: ThemedButtonFactory.create(200, 50, 24, "Next", () {
          String proxyName = _proxyName.value.text;
          String proxyDescription = _proxyDescription.value.text;
          _userSignUpBloc.add(ProxyDetailsSubmittedEvent(
            proxyName: proxyName,
            proxyDescription: proxyDescription,
          ));
        }),
      );

  void _locationSearchDelegate(Place place) async {
    var geo = await place.geolocation;
    LatLng coord = geo.coordinates;
    if (coord == null) {
      return;
    }
    AddressComponents components = AddressComponents.fromGeolocation(geo);
    _userSignUpBloc.add(ProxyLocationSubmittedEvent(
        components, coord.longitude, coord.latitude));
  }
}

class ProxyDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: NoGlowSingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: ProxyDetailsForm(),
      )),
    ));
  }
}
