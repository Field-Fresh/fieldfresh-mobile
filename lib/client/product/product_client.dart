
import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:fieldfreshmobile/client/field_fresh_api_client.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/util/extensions.dart';
import 'package:flutter/foundation.dart';

import 'response.dart';

class ProductClient {
  final FieldFreshApi apiClient;

  final String _productUrl = "/products";

  ProductClient({@required this.apiClient});

  Future<PendingProductsResponse> getPendingProducts(Side side) async {
    var sideType = EnumToString.convertToString(side);

    Uri url = Uri.http(
        apiClient.baseURL, "$_productUrl/pending", {"side": sideType});
    final response = await apiClient.httpClient.get(
      url,
    );
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return PendingProductsResponse.fromJson(results);
    } else {
      print(results);
      throw Error();
    }
  }

  Future<List<Product>> searchProducts(String searchText, int limit) async {
    Map<String, String> params = {};
    params.putIfNotNull("limit", limit.toString());
    params.putIfAbsent("searchText", () => searchText);
    Uri url = Uri.http(
        apiClient.baseURL, "$_productUrl/search", params);
    final response = await apiClient.httpClient.get(
      url,
    );
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return (results as List).map((e) => Product.fromJson(e)).toList();
    } else {
      print(results);
      throw Error();
    }
  }
}
