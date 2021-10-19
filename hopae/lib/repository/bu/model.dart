// ignore_for_file: constant_identifier_names

class LoginInfo {

    final bool? isLogined;

    final String? userId;

    final String? univCode;

    final String? userName;

    final String? deptCode;

    const LoginInfo({ this.isLogined, this.userId, this.univCode, this.userName, this.deptCode });

    factory LoginInfo.fromJson(Map<String, dynamic> json) {
        return LoginInfo(
            isLogined: json['isLogined'],
            userId: json['userId'],
            univCode: json['univCd'],
            userName: json['userNm'],
            deptCode: json['deptCode']
        );
    }

}

class LoginResponse {

    static const int STATE_SUCCESS = 0;
    static const int STATE_MESSAGE = 1;
    static const int STATE_CHANGE = 2;

    final int state;

    final String? message;

    final String? redirect;

    const LoginResponse({ required this.state, this.message, this.redirect });

}