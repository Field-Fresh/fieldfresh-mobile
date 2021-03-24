import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';

typedef MethodResponse<T> = void Function(T value);

enum Environment { develop, production }

class AppConfig {
  static final String kChannelName = 'flavor';
  static final String kMethodName = 'getFlavor';

  Environment flavor;
  final String apiHost;

  AppConfig({this.flavor, this.apiHost});

  static AppConfig _instance;
  static AppConfig getInstance() => _instance;

  static _setupEnv(String flavorName) async {

    String apiHost;
    Environment flavor;
    // TODO want to get this stuff from the environment or create a SSM client
    if (flavorName == 'develop') {
      apiHost = Platform.isAndroid ? "10.0.2.2:9090" : "localhost:9090";
      flavor = Environment.develop;
    } else if (flavorName == 'production') {
      apiHost = 'ec2-34-227-254-119.compute-1.amazonaws.com';
      flavor = Environment.production;
    }
    _instance = AppConfig(flavor: flavor, apiHost: apiHost);
  }

  static configure(MethodResponse fn) async {
    try {
      final flavor = await MethodChannel(kChannelName).invokeMethod(kMethodName);
      log("Started with flavor $flavor");
      _setupEnv(flavor);
      fn(true);
    } catch (e) {
      log("Failed: '${e.message}'");
      fn(false);
    }
  }
}
