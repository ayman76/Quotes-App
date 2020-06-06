import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quotes_app/pages/quotePage.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quotes App',
        home: SplashScreen());
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuotePage())),
    );
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 3),
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              'logo/logo.png',
              height: size.width / 2.5,
              width: size.width / 2.5,
            ),
          ),
        ),
      ),
    );
  }
}
