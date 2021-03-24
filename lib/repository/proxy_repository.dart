import 'package:fieldfreshmobile/client/proxy/proxy_client.dart';
import 'package:fieldfreshmobile/client/proxy/request.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';


class ProxyRepository {
  final ProxyClient _proxyClient;

  ProxyRepository(this._proxyClient);

  Future<Proxy> createProxy(Proxy proxy) async {
    return _proxyClient.createProxy(CreateProxyRequest.fromModel(proxy));
  }

  Future<Proxy> getProxy(String id) async {
    return _proxyClient.getById(id);
  }

  Future<List<Proxy>> getProxies() async {
    return _proxyClient.getProxies();
  }

  Future<Proxy> updateProxy(Proxy proxy) async {
    return proxy;
  }
}
