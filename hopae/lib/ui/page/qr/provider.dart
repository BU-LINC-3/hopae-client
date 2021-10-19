
import 'package:hopae/arch/observable.dart';
import 'package:hopae/arch/provider.dart';
import 'package:hopae/repository/core/model.dart';
import 'package:hopae/repository/core/service.dart';
import 'package:retrofit/retrofit.dart';

class QRDataProvider extends DataProvider {

    final CoreService _service = CoreService();

    ObservableData<HttpResponse<SessionInfo>>? _sessionInfo;

    void requestSession(int univerGu, String userId, String userPw) {
        _service.requestSession(univerGu, userId, userPw).then((value) {
            _sessionInfo!.setData(value);
        });
    }

    ObservableData<HttpResponse<SessionInfo>>? get getSessionInfo {
        _sessionInfo ??= ObservableData();

        return _sessionInfo;
    }
}
