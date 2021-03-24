import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:fieldfreshmobile/client/field_fresh_api_client.dart';
import 'package:fieldfreshmobile/models/api/order/buy_order.dart';
import 'package:fieldfreshmobile/models/api/order/match.dart';
import 'package:fieldfreshmobile/models/api/order/sell_order.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';
import 'package:fieldfreshmobile/models/api/user/tokens.dart';
import 'package:fieldfreshmobile/util/auth.dart';
import 'package:fieldfreshmobile/util/extensions.dart';
import 'package:flutter/foundation.dart';

import 'requests.dart';
import 'response.dart';

class OrderClient {
  final FieldFreshApi apiClient;

  final String _orderUrl = "/orders";

  OrderClient({@required this.apiClient});

  Future<OrdersGetResponse> getOrders(OrdersGetRequest request) async {
    Map<String, String> params = {};
    params.putIfNotNull("side", EnumToString.convertToString(request.side));
    params.putIfNotNull("status", EnumToString.convertToString(request.status));
    Uri url = Uri.http(apiClient.baseURL, "$_orderUrl", params);
    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.get(
      url,
      headers:
          apiClient.addAuthenticationHeader(apiClient.basePostHeader, tokens),
    );
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return OrdersGetResponse.fromJson(results);
    } else {
      print(results);
      throw Error();
    }
  }

  Future<SellOrderDetailsResponse> getSellOrder(String id) async {
    Uri url = Uri.http(apiClient.baseURL, "$_orderUrl/sell/$id");
    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.get(
      url,
      headers:
          apiClient.addAuthenticationHeader(apiClient.basePostHeader, tokens),
    );
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return SellOrderDetailsResponse.fromJson(results);
    } else {
      print(results);
      throw Error();
    }
  }

  Future<BuyOrderDetailsResponse> getBuyOrder(String id) async {
    Uri url = Uri.http(apiClient.baseURL, "$_orderUrl/buy/$id");
    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.get(
      url,
      headers:
          apiClient.addAuthenticationHeader(apiClient.basePostHeader, tokens),
    );
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return BuyOrderDetailsResponse.fromJson(results);
    } else {
      print(results);
      throw Error();
    }
  }

  Future<BuyOrder> createBuyOrder(BuyOrder buyOrder) async {
    Uri url = Uri.http(
      apiClient.baseURL,
      "$_orderUrl/buy",
    );

    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.post(url,
        headers:
            apiClient.addAuthenticationHeader(apiClient.basePostHeader, tokens),
        body: jsonEncode({
          "proxyId": buyOrder.proxyId,
          "buyProducts": buyOrder.buyProducts
              .map((bp) => {
                    "earliestDate": bp.earliestDate.toIso8601String(),
                    "latestDate": bp.latestDate.toIso8601String(),
                    "maxPriceCents": bp.maxPriceCents,
                    "volume": bp.volume,
                    "productId": bp.product.id
                  })
              .toList()
        }));
    final results = json.decode(response.body);
    if (response.statusCode == 200) {
      return BuyOrder.fromJson(results);
    } else {
      print(results);
      throw Error();
    }
  }

  Future<List<BuyProduct>> getBuyProducts(Status status, String proxyId) async {
    Map<String, String> params = {};
    params.putIfNotNull("proxyId", proxyId);
    params.putIfNotNull("status", EnumToString.convertToString(status));
    Uri url = Uri.http(apiClient.baseURL, "$_orderUrl/buy", params);
    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.get(
      url,
      headers:
          apiClient.addAuthenticationHeader(apiClient.basePostHeader, tokens),
    );
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return (results as List).map((e) => BuyProduct.fromJson(e)).toList();
    } else {
      print(results);
      throw Error();
    }
  }

  Future<List<SellProduct>> getSellProducts(
      Status status, String proxyId) async {
    Map<String, String> params = {};
    params.putIfNotNull("proxyId", proxyId);
    params.putIfNotNull("status", EnumToString.convertToString(status));
    Uri url = Uri.http(apiClient.baseURL, "$_orderUrl/sell", params);
    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.get(
      url,
      headers:
          apiClient.addAuthenticationHeader(apiClient.basePostHeader, tokens),
    );
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return (results as List).map((e) => SellProduct.fromJson(e)).toList();
    } else {
      print(results);
      throw Error();
    }
  }

  Future<List<Match>> getMatches(String proxyId, Side orderSide) async {
    Map<String, String> params = {};
    params.putIfNotNull("side", EnumToString.convertToString(orderSide));
    Uri url =
        Uri.http(apiClient.baseURL, "$_orderUrl/$proxyId/matches", params);
    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.get(
      url,
      headers:
          apiClient.addAuthenticationHeader(apiClient.basePostHeader, tokens),
    );
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return (results as List).map((e) => Match.fromJson(e)).toList();
    } else {
      print(results);
      throw Error();
    }
  }

  Future<MatchOrderDetailsResponse> getMatchDetails(
      String matchId, String proxyId) async {
    Uri url =
        Uri.http(apiClient.baseURL, "$_orderUrl/$proxyId/match/$matchId");
    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.get(
      url,
      headers:
          apiClient.addAuthenticationHeader(apiClient.basePostHeader, tokens),
    );
    final results = json.decode(response.body);
    if (response.statusCode == 200) {
      return MatchOrderDetailsResponse.fromJson(results);
    } else {
      print(results);
      throw Error();
    }
  }

  Future<SellOrder> createSellOrder(SellOrder sellOrder) async {
    Uri url = Uri.http(
      apiClient.baseURL,
      "$_orderUrl/sell",
    );

    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.post(url,
        headers:
            apiClient.addAuthenticationHeader(apiClient.basePostHeader, tokens),
        body: jsonEncode({
          "proxyId": sellOrder.proxyId,
          "sellProducts": sellOrder.sellProducts
              .map((sp) => {
                    "earliestDate": sp.earliestDate.toIso8601String(),
                    "latestDate": sp.latestDate.toIso8601String(),
                    "minPriceCents": sp.minPriceCents,
                    "serviceRadius": sp.serviceRadius,
                    "volume": sp.volume,
                    "productId": sp.product.id
                  })
              .toList()
        }));
    final results = json.decode(response.body);
    if (response.statusCode == 200) {
      return SellOrder.fromJson(results);
    } else {
      print(results);
      throw Error();
    }
  }

  Future<void> cancelSellOrder(String id) async {
    Uri url = Uri.http(
      apiClient.baseURL,
      "$_orderUrl/sell/$id/cancel",
    );

    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.put(
      url,
      headers:
          apiClient.addAuthenticationHeader(apiClient.basePostHeader, tokens),
    );
    if (response.statusCode == 200) {
      return;
    } else {
      print(response);
      throw Error();
    }
  }

  Future<void> cancelBuyOrder(String id) async {
    Uri url = Uri.http(
      apiClient.baseURL,
      "$_orderUrl/buy/$id/cancel",
    );

    Tokens tokens = await AuthUtil.getAuth();
    final response = await apiClient.httpClient.put(
      url,
      headers:
          apiClient.addAuthenticationHeader(apiClient.basePostHeader, tokens),
    );
    if (response.statusCode == 200) {
      return;
    } else {
      print(response);
      throw Error();
    }
  }
}
