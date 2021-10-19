import 'dart:convert';

import 'package:hopae/repository/bu/model.dart';
import 'package:hopae/repository/bu/service.dart';
import 'package:retrofit/retrofit.dart';

class BUAuthRepository {

    late BUAuthService _service;

    String? _sessionId;

    BUAuthRepository() {
        _service = BUAuthService();
    }

    Future<LoginResponse> requestLogin(int univerGu, String userId, String userPw) {
        return Future<LoginResponse>(() async {
            HttpResponse httpResponse = await _service.requestLogin(univerGu, userId, userPw);
            if (httpResponse.response.statusCode == 200) {
                if (httpResponse.response.isRedirect!) {
                    return LoginResponse(
                        state: LoginResponse.STATE_CHANGE,
                        message: "로그인 오류: 홈페이지에서 비밀번호를 변경해주세요.",
                        redirect: httpResponse.response.redirects.first.location.toString()
                    );
                } else {
                    _sessionId = httpResponse.response.headers.map["set-cookie"]!.last;
                    return const LoginResponse(state: LoginResponse.STATE_SUCCESS);
                }
            }
            return LoginResponse(
                state: LoginResponse.STATE_MESSAGE, 
                message: "로그인 오류",
                redirect: httpResponse.response.redirects.first.location.toString()
            );
        });
    }

    Future<LoginInfo> requestLoginInfo() {
        return Future<LoginInfo>(() async {
            String? response = await _service.requestLoginInfo(_sessionId!);
            Map<String, dynamic> json = jsonDecode(response);
            
            return LoginInfo.fromJson(json);
        });
    }
}