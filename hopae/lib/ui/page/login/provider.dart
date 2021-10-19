
import 'package:hopae/arch/observable.dart';
import 'package:hopae/arch/provider.dart';
import 'package:hopae/repository/bu/model.dart';
import 'package:hopae/repository/bu/repository.dart';

class LoginDataProvider extends DataProvider {

    final BUAuthRepository _repository = BUAuthRepository();

    ObservableData<LoginInfo>? _loginInfo;
    ObservableData<LoginResponse>? _loginResponse;

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

    ObservableData<LoginResponse>? get getLoginResponse {
        _loginResponse ??= ObservableData();

        return _loginResponse;
    }

    ObservableData<LoginInfo>? get getLoginInfo {
        _loginInfo ??= ObservableData();

        return _loginInfo;
    }
}
