
import 'dart:convert';

import 'package:hopae/arch/observable.dart';
import 'package:hopae/arch/provider.dart';
import 'package:hopae/repository/aries/model.dart';
import 'package:hopae/repository/aries/service.dart';
import 'package:hopae/repository/core/model.dart';
import 'package:hopae/repository/core/service.dart';
import 'package:hopae/repository/preference/service.dart';
import 'package:retrofit/retrofit.dart';

class HomeDataProvider extends DataProvider {

    final CoreService _service = CoreService();
    final AriesService _ariesService = AriesService();
    final PreferenceService _prefService = PreferenceService();

    ObservableData<HttpResponse<SessionInfo>>? _sessionInfo;
    
    ObservableData<int>? _port;
    ObservableData<String>? _alias;
    
    ObservableData<Wallet>? _wallet;
    ObservableData<Map<String, dynamic>>? _credentials;
    ObservableData<Map<String, dynamic>>? _invitation;

    void requestSession(int univerGu, String userId, String userPw) {
        _service.requestSession(univerGu, userId, userPw).then((value) => _sessionInfo!.setData(value));
    }

    void requestSetPort(int port) {
        _prefService.setPort(port);
    }

    void requestGetPort() {
        _prefService.getPort().then((value) => _port!.setData(value));
    }

    void requestSetAlias(String alias) {
        _prefService.setAlias(alias);
    }

    void requestGetAlias() {
        _prefService.getAlias().then((value) => _alias!.setData(value));
    }

    void requestWallet(int port) {
        _ariesService.requestWallet(port).then((value) => _wallet!.setData(value));
    }

    void requestCredential(int port) {
        _ariesService.requestCredentials(port, 1).then((value) => _credentials!.setData(jsonDecode(value)['results'][0]));
    }

    void requestInvitation(int port, String alias) {
        _ariesService.requestCreateInvitation("{}", port, alias, true).then((value) => _invitation!.setData(jsonDecode(value)['invitation']));
    }

    ObservableData<HttpResponse<SessionInfo>>? get getSessionInfo {
        _sessionInfo ??= ObservableData();

        return _sessionInfo;
    }

    ObservableData<int>? get getPort {
        _port ??= ObservableData();

        return _port;
    }

    ObservableData<String>? get getAlias {
        _alias ??= ObservableData();

        return _alias;
    }

    ObservableData<Wallet>? get getWallet {
        _wallet ??= ObservableData();

        return _wallet;
    }

    ObservableData<Map<String, dynamic>>? get getCredentials {
        _credentials ??= ObservableData();

        return _credentials;
    }

    ObservableData<Map<String, dynamic>>? get getInvitation {
        _invitation ??= ObservableData();

        return _invitation;
    }
}
