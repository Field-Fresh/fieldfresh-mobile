
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';

import 'client/user/proxy_client.dart';

class ProxyRepository {
  final ProxyClient _proxyClient;

  ProxyRepository(this._proxyClient);

  Future<Proxy> createProxy(Proxy proxy) async {
    return proxy;
  }

  Future<Proxy> updateProxy(Proxy proxy) async {
    return proxy;
  }
}
