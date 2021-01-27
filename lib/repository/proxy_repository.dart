import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';

import 'client/proxy/proxy_client.dart';
import 'client/proxy/request.dart';

class ProxyRepository {
  final ProxyClient _proxyClient;

  ProxyRepository(this._proxyClient);

  Future<Proxy> createProxy(Proxy proxy) async {
    return _proxyClient.createProxy(CreateProxyRequest.fromModel(proxy));
  }

  Future<Proxy> updateProxy(Proxy proxy) async {
    return proxy;
  }
}
