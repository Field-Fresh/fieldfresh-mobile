import 'package:fieldfreshmobile/feature/proxy/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/repository/proxy_repository.dart';
import 'package:fieldfreshmobile/util/constants.dart';
import 'package:fieldfreshmobile/util/preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProxyCubit extends Cubit<ProxyPageState> {
  final ProxyRepository _proxyRepository;

  ProxyCubit(this._proxyRepository) : super(Empty());

  Proxy _defaultProxy;
  List<Proxy> _proxies;

  Future<void> loadProxies() async {
    emit(Loading());

    var _viewerProxyId = await PreferenceUtil.get(DEFAULT_PROXY);

    try {
      _defaultProxy = await _proxyRepository.getProxy(_viewerProxyId);
      _proxies = await _proxyRepository.getProxies();
      emit(Loaded(_defaultProxy, _proxies));
    } catch (e) {
      emit(Error());
    }
  }

  Future<void> setDefaultProxy(Proxy proxy) async {
    emit(Loading());
    await PreferenceUtil.put(DEFAULT_PROXY, proxy.id);
    _defaultProxy = proxy;
    emit(Loaded(proxy, _proxies));
  }
}
