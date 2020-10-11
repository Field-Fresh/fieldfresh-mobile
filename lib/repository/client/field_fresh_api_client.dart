import 'package:fieldfreshmobile/models/user/user.dart';
import 'package:http/http.dart' as http;

class FieldFreshApi {
  final http.Client httpClient;

  final String baseURL = "10.0.2.2:9090";

  final Map<String, String> basePostHeader = {
    "Content-Type": "application/json",
  };

  FieldFreshApi({httpClient,}): this.httpClient = httpClient ?? http.Client();




}