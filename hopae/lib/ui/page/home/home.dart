import 'package:flutter/material.dart';
import 'package:hopae/arch/observable.dart';
import 'package:hopae/helper/helper.dart';
import 'package:hopae/repository/bu/model.dart';
import 'package:hopae/ui/page/home/model.dart';
import 'package:hopae/ui/page/home/provider.dart';
import 'package:hopae/ui/page/qr/qr.dart';
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

    @override
    void initState() {
        super.initState();
        initObservers();
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
                _dataProvider.requestWallet(_port!);
            } else {
                _dataProvider.requestSession(widget.univerGu, widget.userId, widget.userPw);
            }
        }));

        _dataProvider.getInvitation!.addObserver(Observer((data) {
            Helper.navigateRoute(context, QRPage(qrData: IssueQR(sessionId: _sessionId, invitation: data).toJson()));
        }));

        _dataProvider.getCredentials!.addObserver(Observer((data) {

        }));

        _dataProvider.getWallet!.addObserver(Observer((data) {
            _dataProvider.requestCredential(_port!);
        }));
        
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Column(
                children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal * 2, vertical: Sizes.safeAreaVertical),
                        child: Material(
                            color: Colors.blueAccent,
                            child: InkWell(
                                onTap: () => _dataProvider.requestGetPort(),
                                child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal, vertical: Sizes.safeAreaVertical / 2),
                                    child: Text(
                                        "QR",
                                        style: TextStyle(
                                            fontSize: Sizes.fontSizeContents,
                                            color: Colors.white,
                                        ),
                                    ),
                                ),
                            ),
                        )
                    ),
                ],
            ),
        );
    }
}