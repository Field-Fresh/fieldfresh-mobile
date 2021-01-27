import 'dart:convert';

import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/repository/client/field_fresh_api_client.dart';
import 'package:fieldfreshmobile/repository/client/proxy/request.dart';
import 'package:flutter/foundation.dart';

class ProxyClient {
  final FieldFreshApi apiClient;

  final String _proxyUrl = "/proxy";

  ProxyClient({@required this.apiClient});

  Future<Proxy> createProxy(CreateProxyRequest request) async {
    Uri url = Uri.http(
      apiClient.baseURL,
      "$_proxyUrl/new",
    );
    final response = await apiClient.httpClient.post(url,
        headers: apiClient.basePostHeader,
        body: jsonEncode({
          "userid": request.userid,
          "name": request.name,
          "description": request.description,
          "streetAddress": request.streetAddress,
          "city": request.city,
          "province": request.province,
          "country": request.country,
          "postalCode": request.postalCode,
          "lat": request.lat,
          "long": request.long,
        }));
    final results = json.decode(response.body);
    if (response.statusCode == 200) {
      return Proxy.fromJson(results);
    } else {
      print(results);
      throw Error();
    }
  }
}
