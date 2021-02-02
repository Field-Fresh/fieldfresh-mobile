import 'dart:ffi';

import 'package:fieldfreshmobile/feature/home/event/events.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:flutter/foundation.dart';

class CreateProxyRequest {
  final String userid;
  final String name;
  final String description;
  final String streetAddress;
  final String city;
  final String province;
  final String country;
  final String postalCode;
  final double lat;
  final double long;

  static CreateProxyRequest fromModel(Proxy proxy) {
    return CreateProxyRequest(
        proxy.userId,
        proxy.name,
        proxy.description,
        proxy.streetAddress,
        proxy.city,
        proxy.province,
        proxy.country,
        proxy.postalCode,
        proxy.lat,
        proxy.long);
  }

  CreateProxyRequest(
      this.userid,
      this.name,
      this.description,
      this.streetAddress,
      this.city,
      this.province,
      this.country,
      this.postalCode,
      this.lat,
      this.long);
}
