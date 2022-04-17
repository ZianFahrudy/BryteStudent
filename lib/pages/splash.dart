import 'dart:async';
import 'package:bryte/pages/auth/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:bryte/theme.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Signin()),
            ModalRoute.withName('Signin')));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget logo2() {
      return Container(
        padding: const EdgeInsets.only(bottom: 42),
        color: bryteDarkPurple,
        width: double.infinity,
        child: Image.asset(
          'assets/logo2.png',
          height: 28,
          width: 121,
        ),
      );
    }

    return Scaffold(
        bottomSheet: logo2(),
        backgroundColor: bryteDarkPurple,
        body: Center(
            child: Container(
          width: 78,
          height: 30,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/splash.png'))),
        )));
  }
}
