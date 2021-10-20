
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
    ObservableData<List<dynamic>>? _credentials;
    ObservableData<Map<String, dynamic>>? _invitation;
    ObservableData<bool>? _invitationSuccess;
    ObservableData<String>? _did;

    ObservableData<bool>? _revoked;
    ObservableData<bool>? _deleted;

    void requestSession(int univerGu, String userId, String userPw) {
        _service.requestSession(univerGu, userId, userPw).then((value) => _sessionInfo!.setData(value));
    }

    void requestClearAgentInfo() {
        _prefService.removePort();
        _prefService.removeAlias();
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
        _ariesService.requestCredentials(port).then((value) {
            List<dynamic> result = (jsonDecode(value)['results'] as List);
            result.sort((a, b) => int.parse(a['cred_rev_id']).compareTo(int.parse(b['cred_rev_id'])));
            _credentials!.setData(result);
        });
    }

    void requestInvitation(int port, String alias) {
        _ariesService.requestCreateInvitation("{}", port, alias, true).then((value) => _invitation!.setData(jsonDecode(value)['invitation']));
    }

    void requestIsInvitationSuccess(int port, String alias) {
        _ariesService.requestConnections(port, alias, "active").then((value) {
            List<dynamic> connections = (jsonDecode(value)['results'] as List);
            _invitationSuccess!.setData(connections.isNotEmpty);
            if (connections.isNotEmpty) {
                _did!.setData(connections.first['my_did']);
            }
        });
    }

    void requestDelCredential(int port, String credId) {
        _ariesService.requestDelCredentials(port, credId).then((value) => _deleted!.setData(value.response.statusCode == 200));
    }

    void requestRevoke(String credRevId, String revRegId) {
        _service.requestRevoke(credRevId, revRegId).then((value) => _revoked!.setData((jsonDecode(value)['revoked'] as bool)));
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

    ObservableData<List<dynamic>>? get getCredentials {
        _credentials ??= ObservableData();

        return _credentials;
    }

    ObservableData<Map<String, dynamic>>? get getInvitation {
        _invitation ??= ObservableData();

        return _invitation;
    }

    ObservableData<bool>? get getInvitationSuccess {
        _invitationSuccess ??= ObservableData();

        return _invitationSuccess;
    }

    ObservableData<String>? get getDID {
        _did ??= ObservableData();

        return _did;
    }

    ObservableData<bool>? get getDeleted {
        _deleted ??= ObservableData();

        return _deleted;
    }

    ObservableData<bool>? get getRevoked {
        _revoked ??= ObservableData();

        return _revoked;
    }
}
