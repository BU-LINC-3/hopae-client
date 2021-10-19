import 'package:flutter/material.dart';
import 'package:hopae/arch/observable.dart';
import 'package:hopae/helper/helper.dart';
import 'package:hopae/repository/bu/model.dart';
import 'package:hopae/ui/page/login/provider.dart';
import 'package:hopae/ui/page/home/home.dart';
import 'package:hopae/ui/widget/sizes.dart';

class LoginPage extends StatefulWidget {

    const LoginPage({ Key? key }) : super(key: key);

    @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    final LoginDataProvider _dataProvider = LoginDataProvider();

    String? _userId, _userPw;

    @override
    void initState() {
        super.initState();
        initObservers();
        _dataProvider.requestGetUserId();
    }

    void initObservers() {
        _dataProvider.getLoginResponse!.addObserver(Observer((data) {
            if (data.state == LoginResponse.STATE_SUCCESS) {
                _dataProvider.requestLoginInfo();
            } else {
                Helper.snack(context, text: data.message!, label: data.state.toString());
            }
        }));

        _dataProvider.getLoginInfo!.addObserver(Observer((data) {
            _dataProvider.requestSetUserId(_userId!);
            _dataProvider.requestSetUserPw(_userPw!);

            Helper.navigateRoute(context, HomePage(
                loginInfo: data, 
                univerGu: 1,
                userId: _userId!,
                userPw: _userPw!,
            ));
        }));

        _dataProvider.getUserId!.addObserver(Observer((data) {
            if (data != "") {
                setState(() {
                    _userId = data;
                });
                _dataProvider.requestGetUserPw();
            }
        }));

        _dataProvider.getUserPw!.addObserver(Observer((data) {
            if (data != "") {
                setState(() {
                    _userPw = data;
                });
                _dataProvider.requestLogin(1, _userId!, _userPw!);
            }
        }));
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Column(
                children: [
                    Container(
                        width: double.infinity,
                        color: Colors.blueAccent,
                        child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: Sizes.safeAreaVertical * 2),
                            child: Text(
                                "HOPAE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Sizes.fontSizeSubtitle,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                ),
                            ),
                        ),
                    ),
                    Row(
                        children: [
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal * 2),
                                    child: TextField(
                                        cursorColor: Theme.of(context).primaryColor,
                                        decoration: InputDecoration(
                                            hintText: "학번",
                                            border: InputBorder.none,
                                            focusColor: Theme.of(context).primaryColor,
                                            focusedBorder: InputBorder.none,
                                        ),
                                        style: const TextStyle(
                                            fontSize: Sizes.fontSizeContents,
                                            fontWeight: FontWeight.w500,
                                        ),
                                        onChanged: (value) {
                                            setState(() {
                                                _userId = value;
                                            });
                                        },
                                        maxLines: 1,
                                    ),
                                ),
                            ),
                        ],
                    ),
                    Row(
                        children: [
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal * 2),
                                    child: TextField(
                                        cursorColor: Theme.of(context).primaryColor,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: "패스워드",
                                            border: InputBorder.none,
                                            focusColor: Theme.of(context).primaryColor,
                                            focusedBorder: InputBorder.none,
                                        ),
                                        style: const TextStyle(
                                            fontSize: Sizes.fontSizeContents,
                                            fontWeight: FontWeight.w500,
                                        ),
                                        onChanged: (value) {
                                            setState(() {
                                                _userPw = value;
                                            });
                                        },
                                        maxLines: 1,
                                    ),
                                ),
                            ),
                        ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal * 2, vertical: Sizes.safeAreaVertical),
                        child: Material(
                            color: Colors.blueAccent,
                            child: InkWell(
                                onTap: () => _dataProvider.requestLogin(1, _userId!, _userPw!),
                                child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal, vertical: Sizes.safeAreaVertical / 2),
                                    child: Text(
                                        "LOGIN",
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