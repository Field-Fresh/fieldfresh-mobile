import 'dart:io';

import 'package:fieldfreshmobile/feature/home/bloc/side_type.dart';
import 'package:fieldfreshmobile/repository/client/field_fresh_api_client.dart';

import 'dart:convert';

import 'package:fieldfreshmobile/repository/client/product/response.dart';
import 'package:flutter/foundation.dart';

import 'package:enum_to_string/enum_to_string.dart';

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
}
