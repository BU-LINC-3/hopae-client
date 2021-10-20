import 'package:flutter/material.dart';
import 'package:hopae/arch/observable.dart';
import 'package:hopae/helper/helper.dart';
import 'package:hopae/repository/bu/model.dart';
import 'package:hopae/ui/page/home/model.dart';
import 'package:hopae/ui/page/home/provider.dart';
import 'package:hopae/ui/page/qr/qr.dart';
import 'package:hopae/ui/widget/loading.dart';
import 'package:hopae/ui/widget/sizes.dart';

class HomePage extends StatefulWidget {

    final LoginInfo loginInfo;
    final int univerGu;
    final String userId;
    final String userPw;

    const HomePage({ 
        required this.loginInfo, 
        required this.univerGu, required this.userId, required this.userPw, 
        Key? key 
    }) : super(key: key);

    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    final HomeDataProvider _dataProvider = HomeDataProvider();

    int? _port;
    String? _alias;
    String? _sessionId;

    String? _qrData;

    Map<String, dynamic>? _credential;

    bool? _isLoading;
    bool? _hasCred;

    @override
    void initState() {
        super.initState();
        initObservers();
        _isLoading = true;
        _dataProvider.requestGetPort();
    }

    void initObservers() {
        _dataProvider.getSessionInfo!.addObserver(Observer((data) {
            _port = data.data.port;
            _alias = data.data.alias;
            _sessionId = data.response.headers.value("set-cookie")!.split(";")[0];

            _dataProvider.requestInvitation(_port!, _alias!);
        }));

        _dataProvider.getPort!.addObserver(Observer((data) {
            if (data != -1) {
                _port = data;
                _dataProvider.requestGetAlias();
            } else {
                _dataProvider.requestSession(widget.univerGu, widget.userId, widget.userPw);
            }
        }));

        _dataProvider.getAlias!.addObserver(Observer((data) {
            if (data != "") {
                _alias = data;
                _dataProvider.requestIsInvitationSuccess(_port!, _alias!);
            } else {
                _dataProvider.requestSession(widget.univerGu, widget.userId, widget.userPw);
            }
        }));

        _dataProvider.getInvitation!.addObserver(Observer((data) {
            _dataProvider.requestSetPort(_port!);
            _dataProvider.requestSetAlias(_alias!);
            
            _qrData = IssueQR(
                sessionId: _sessionId, 
                invitation: data
            ).toJson();

            setState(() {
                _isLoading = false;
                _hasCred = false;
            });
        }));
        
        _dataProvider.getInvitationSuccess!.addObserver(Observer((data) {
            if (data) {
                _dataProvider.requestCredential(_port!);
            } else {
                _dataProvider.requestSession(widget.univerGu, widget.userId, widget.userPw);
            }
        }));

        _dataProvider.getCredentials!.addObserver(Observer((data) {
            if (data.isNotEmpty) {
                _qrData = ProofQR(
                    alias: _alias, 
                    credRevId: data['cred_rev_id'], 
                    revRegId: data['rev_reg_id']
                ).toJson();

                _credential = data;

                setState(() {
                    _isLoading = false;
                    _hasCred = true;
                });
            } else {
                _dataProvider.requestClearAgentInfo();
            }
        }));
    }

    @override
    Widget build(BuildContext context) {
        return LoadingWrapper(
            isLoading: _isLoading ??= false,
            child: Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: AppBar(
                    backgroundColor: Colors.blueAccent,
                    toolbarHeight: 150,
                    automaticallyImplyLeading: false,
                    title: Align(
                        alignment: Alignment.center,
                        child: Column(
                            children: const [ 
                                Text(
                                    "HOPAE",
                                    style: TextStyle(
                                        fontSize: Sizes.fontSizeTitle,
                                    ),
                                ),
                                Text(
                                    "DID 기반 백석대학교 출입 시스템",
                                    style: TextStyle(
                                        fontSize: Sizes.fontSizeContents,
                                    ),
                                ),
                            ],
                        ),
                    ),
                ),
                body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal, vertical: Sizes.safeAreaVertical),
                    child: Column(
                        children: [
                            Container(
                                color: Colors.black.withOpacity(0.05),
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Text(
                                        "환영합니다, ${widget.loginInfo.userName}(${widget.loginInfo.userId})님",
                                        style: const TextStyle(
                                            fontSize: Sizes.fontSizeContents,
                                        ),
                                    ),
                                ),
                            ),
                            const Divider(),
                            Container(
                                color: Colors.black.withOpacity(0.05),
                                width: double.infinity,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget> [
                                        const Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                                padding: EdgeInsets.only(left: 24, right: 24, top: 6),
                                                child: Text(
                                                    "현재 출입증",
                                                    style: TextStyle(
                                                        fontSize: Sizes.fontSizeContents,
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                ),
                                            ),
                                        ),
                                        const Divider(),
                                    ] + credentialInfo(_credential) + [
                                        const Divider(),
                                    ],
                                ),
                            ),
                            const Expanded(
                                child: SizedBox(),
                            ),
                        ] + ((_hasCred ??= false) ? [
                            const Divider(),
                            SizedBox( 
                                width: double.infinity,
                                child: Material(
                                    color: Colors.blueAccent,
                                    child: InkWell(
                                        onTap: () {
                                            if (_hasCred ??= false) {
                                                Helper.navigateRoute(context, QRPage(
                                                    qrData: _qrData!,
                                                    extraText: credentialInfo(_credential),
                                                ));
                                            }
                                        },
                                        child: const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal, vertical: Sizes.safeAreaVertical / 2),
                                            child: Text(
                                                "기존 출입증 인증하기",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: Sizes.fontSizeContents,
                                                    color: Colors.white,
                                                ),
                                            ),
                                        ),
                                    ),
                                ),
                            ),
                        ] : []) + [
                            const Divider(),
                            SizedBox( 
                                width: double.infinity,
                                child: Material(
                                    color: Colors.red,
                                    child: InkWell(
                                        onTap: () {
                                            if (_hasCred ??= false) {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext context) {
                                                        return AlertDialog(
                                                            title: const Text('주의'),
                                                            content: SingleChildScrollView(
                                                                child: ListBody(
                                                                    children: const <Widget>[
                                                                        Text("기존 출입증 정보가 기기에서 제거됩니다."),
                                                                        Text("정말 새로 발급 받으시겠습니까?"),
                                                                    ],
                                                                ),
                                                            ),
                                                            actions: <Widget>[
                                                                TextButton(
                                                                    child: const Text("취소"),
                                                                    onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                    },
                                                                ),
                                                                TextButton(
                                                                    child: const Text("예"),
                                                                    onPressed: () {
                                                                        _dataProvider.requestSession(widget.univerGu, widget.userId, widget.userPw);
                                                                    },
                                                                ),
                                                            ],
                                                        );
                                                    },
                                                );
                                            } else {
                                                Helper.navigateRoute(context, QRPage(
                                                    qrData: _qrData!,
                                                ));
                                            }
                                        },
                                        child: const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal, vertical: Sizes.safeAreaVertical / 2),
                                            child: Text(
                                                "출입증 새로 발급 요청하기",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: Sizes.fontSizeContents,
                                                    color: Colors.white,
                                                ),
                                            ),
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

    List<Widget> credentialInfo(Map<String, dynamic>? credential) {
        return ((credential != null) ? <Widget> [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                child: Text(
                    "측정 체온: \t${int.parse(credential['attrs']['temp']) * 0.1}도",
                    style: const TextStyle(
                        fontSize: Sizes.fontSizeContents,
                    ),
                ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                child: Text(
                    "출입자 이름: \t${credential['attrs']['name']}",
                    style: const TextStyle(
                        fontSize: Sizes.fontSizeContents,
                    ),
                ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                child: Text(
                    "출입자 학번: \t${credential['attrs']['student_id']}",
                    style: const TextStyle(
                        fontSize: Sizes.fontSizeContents,
                    ),
                ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                child: Text(
                    "발급 일자: \t${DateTime.fromMillisecondsSinceEpoch(int.parse(credential['attrs']['timestamp']) * 1000).toString()}",
                    style: const TextStyle(
                        fontSize: Sizes.fontSizeContents,
                    ),
                ),
            ),
        ] : <Widget> [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                child: Text(
                    "출입증 정보가 없습니다.",
                    style: TextStyle(
                        fontSize: Sizes.fontSizeContents,
                    ),
                ),
            ),
        ]);
    }
}