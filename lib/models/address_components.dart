import 'package:flutter/cupertino.dart';
import 'package:search_map_place/search_map_place.dart';

class AddressComponents {
  final String streetAddress;
  final String city;
  final String province;
  final String country;
  final String postalCode;

  AddressComponents(
      {@required this.streetAddress,
      @required this.city,
      @required this.province,
      @required this.country,
      @required this.postalCode});

  static fromGeolocation(Geolocation geo) {
    List<dynamic> components = geo.fullJSON["address_components"];
    Map<String, String> typeToName = Map.fromIterable(components,
        key: (e) => e["types"][0], value: (e) => e["short_name"]);
    return AddressComponents(
      streetAddress: "${typeToName["street_number"]} ${typeToName["route"]}",
      city: typeToName["locality"],
      province: typeToName["administrative_area_level_1"],
      country: typeToName["country"],
      postalCode: typeToName["postal_code"],
    );
  }
}
