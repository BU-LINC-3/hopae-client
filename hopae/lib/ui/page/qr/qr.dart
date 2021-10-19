import 'package:flutter/material.dart';
import 'package:hopae/arch/observable.dart';
import 'package:hopae/repository/bu/model.dart';
import 'package:hopae/ui/page/qr/provider.dart';

class QRPage extends StatefulWidget {

    final LoginInfo loginInfo;
    final int univerGu;
    final String userId;
    final String userPw;

    const QRPage({ 
        required this.loginInfo, 
        required this.univerGu, required this.userId, required this.userPw, 
        Key? key 
    }) : super(key: key);

    @override
    _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {

    final QRDataProvider _dataProvider = QRDataProvider();

    @override
    void initState() {
        super.initState();
        initObservers();
        _dataProvider.requestSession(widget.univerGu, widget.userId, widget.userPw);
    }

    void initObservers() {
        _dataProvider.getSessionInfo!.addObserver(Observer((data) {

        }));
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
        );
    }
}