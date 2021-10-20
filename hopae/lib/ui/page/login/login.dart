import 'package:flutter/material.dart';
import 'package:hopae/arch/observable.dart';
import 'package:hopae/helper/helper.dart';
import 'package:hopae/repository/bu/model.dart';
import 'package:hopae/ui/page/login/provider.dart';
import 'package:hopae/ui/page/home/home.dart';
import 'package:hopae/ui/widget/loading.dart';
import 'package:hopae/ui/widget/sizes.dart';

class LoginPage extends StatefulWidget {

    const LoginPage({ Key? key }) : super(key: key);

    @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    final LoginDataProvider _dataProvider = LoginDataProvider();

    String? _userId, _userPw;

    bool? _isLoading;

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

            Navigator.pop(context);
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
                    _isLoading = true;
                });
                _dataProvider.requestGetUserPw();
            }
        }));

        _dataProvider.getUserPw!.addObserver(Observer((data) {
            if (data != "") {
                setState(() {
                    _userPw = data;
                    _isLoading = true;
                });
                _dataProvider.requestLogin(1, _userId!, _userPw!);
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
                    toolbarHeight: 200,
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
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal * 2),
                    child: Column(
                        children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Container(
                                    color: Colors.black.withOpacity(0.1),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
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
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Container(
                                    color: Colors.black.withOpacity(0.1),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
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
                            ),
                            const Expanded(
                                child: SizedBox(),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Sizes.safeAreaHorizontal * 2, vertical: Sizes.safeAreaVertical),
                                child: Material(
                                    color: Colors.blueAccent,
                                    child: InkWell(
                                        onTap: () {
                                            if (_userId != "" && _userPw != "") {
                                                setState(() {
                                                    _isLoading = true;
                                                });
                                                _dataProvider.requestLogin(1, _userId!, _userPw!);
                                            }
                                        },
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
                ),
            ),
        );
    }
}