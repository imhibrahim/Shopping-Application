import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shoopingapp/screens/Auth_UI/welcome.dart';
import 'package:shoopingapp/screens/User_penal/main_screen.dart';
import 'package:shoopingapp/utlis/app_constain.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstent.appSecondaryColor,
      appBar: AppBar(backgroundColor: AppConstent.appSecondaryColor),

      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 150),
                child: Image.asset("assets/pic/splash.gif"),
              ),
              Container(
                margin: EdgeInsets.only(top: 210),
                child: Text(
                  AppConstent.appPoweredBy,
                  style: TextStyle(color: AppConstent.appTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
