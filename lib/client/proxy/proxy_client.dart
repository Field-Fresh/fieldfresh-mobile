import 'dart:convert';

import 'package:fieldfreshmobile/client/field_fresh_api_client.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/models/api/user/tokens.dart';
import 'package:fieldfreshmobile/util/auth.dart';
import 'package:flutter/foundation.dart';

import 'request.dart';

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
        headers: apiClient.basePostHeader(),
        body: jsonEncode({
          "userId": request.userid,
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

  Future<List<Proxy>> getProxies() async {
    Uri url =
    Uri.http(apiClient.baseURL, "$_proxyUrl");
    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.get(
      url,
      headers:
      apiClient.addAuthenticationHeader(apiClient.basePostHeader(), tokens),
    );
    final results = json.decode(response.body);
    if (response.statusCode == 200) {
      return (results as List).map((e) => Proxy.fromJson(e)).toList();
    } else {
      print(results);
      throw Error();
    }
  }

  Future<Proxy> getById(String id) async {
    Uri url =
    Uri.http(apiClient.baseURL, "$_proxyUrl/$id");
    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.get(
      url,
      headers:
      apiClient.addAuthenticationHeader(apiClient.basePostHeader(), tokens),
    );
    final results = json.decode(response.body);
    if (response.statusCode == 200) {
      return Proxy.fromJson(results);
    } else {
      print(results);
      throw Error();
    }
  }
}
