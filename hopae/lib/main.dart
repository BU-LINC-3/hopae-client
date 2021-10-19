import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hopae/ui/page/login/login.dart';

void main() {
    HttpOverrides.global = CustomHttpOverrides();
    runApp(const App());
}

class CustomHttpOverrides extends HttpOverrides{

    @override
    HttpClient createHttpClient(SecurityContext? context){
        return super.createHttpClient(context)
            ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
    }
}

class App extends StatelessWidget {

    const App({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: ThemeData.light().copyWith(
                primaryColor: Colors.black,
                backgroundColor: Colors.white,
                textTheme: ThemeData.light().textTheme.apply(
                    bodyColor: Colors.black,
                ),
            ),
            darkTheme: ThemeData.dark().copyWith(
                primaryColor: Colors.white,
                backgroundColor: Colors.black,
                textTheme: ThemeData.dark().textTheme.apply(
                    bodyColor: Colors.white,
                ),
            ),
            home: const LoginPage(),
        );
    }
}
