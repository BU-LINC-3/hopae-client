
import 'package:hopae/arch/observable.dart';
import 'package:hopae/arch/provider.dart';
import 'package:hopae/repository/bu/model.dart';
import 'package:hopae/repository/bu/repository.dart';
import 'package:hopae/repository/preference/service.dart';

class LoginDataProvider extends DataProvider {

    final BUAuthRepository _repository = BUAuthRepository();
    final PreferenceService _prefService = PreferenceService();

    ObservableData<LoginInfo>? _loginInfo;
    ObservableData<LoginResponse>? _loginResponse;

    ObservableData<String>? _userId;
    ObservableData<String>? _userPw;

    void requestLogin(int univerGu, String userId, String userPw) {
        _repository.requestLogin(univerGu, userId, userPw).then((value) {
            _loginResponse!.setData(value);
        });
    }

    void requestLoginInfo() {
        _repository.requestLoginInfo().then((value) {
            _loginInfo!.setData(value);
        });
    }

    void requestSetUserId(String userId) {
        _prefService.setUserId(userId);
    }

    void requestGetUserId() {
        _prefService.getUserId().then((value) => _userId!.setData(value));
    }

    void requestSetUserPw(String userPw) {
        _prefService.setUserPw(userPw);
    }

    void requestGetUserPw() {
        _prefService.getUserPw().then((value) => _userPw!.setData(value));
    }

    ObservableData<LoginResponse>? get getLoginResponse {
        _loginResponse ??= ObservableData();

        return _loginResponse;
    }

    ObservableData<LoginInfo>? get getLoginInfo {
        _loginInfo ??= ObservableData();

        return _loginInfo;
    }

    ObservableData<String>? get getUserId {
        _userId ??= ObservableData();

        return _userId;
    }

    ObservableData<String>? get getUserPw {
        _userPw ??= ObservableData();

        return _userPw;
    }
}
