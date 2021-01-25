
import 'package:fieldfreshmobile/repository/client/field_fresh_api_client.dart';
import 'package:flutter/foundation.dart';

class ProxyClient {
  final FieldFreshApi apiClient;

  final String _proxyUrl = "/proxy";

  ProxyClient({@required this.apiClient});
}