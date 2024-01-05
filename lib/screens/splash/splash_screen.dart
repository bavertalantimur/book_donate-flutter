import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1),
        () => Navigator.pushNamed(context, '/loginPage'));
    return const Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Merhaba Hoşgeldiniz',
              style: TextStyle(color: Colors.black, fontSize: 50),
            ),
          )
        ],
      ),
    ));
  }
}
