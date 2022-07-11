import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:sell/screens/location_screen.dart';


import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {

    Timer(
      Duration(
        seconds: 3,
      ),(){
      FirebaseAuth.instance.authStateChanges().listen((User? user){
        if(user == null){
          // not signed in
          Navigator.pushReplacementNamed (context, LoginScreen.id);
        }
        else{
          //signed in
          Navigator.pushReplacementNamed (context, LocationScreen.id);
        }
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    const colorizeColors = [
      Colors.white,
      Colors.cyan,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 30.0,
      fontFamily: 'Lato',
    );

    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/pic.png', 
            color: Colors.white,
            ),
            SizedBox(
              height:10,
              ),
          AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Buy or Sell',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  
                ],
                isRepeatingAnimation: true,
                onTap: () {
                  print("Tap Event");
                },
              
            ),
          ],
          ),
      ),
      
    );
  }
}
  
  