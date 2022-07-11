import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:sell/screens/authentication/phoneauth_screen.dart';
import 'package:sell/services/phoneauth_service.dart';

import '../screens/authentication/google_auth.dart';

class AuthUi extends StatelessWidget {
  const AuthUi({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        SizedBox(
          width: 220,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)
            ),
            onPressed: (){
               Navigator.pushNamed(context, PhoneAuthScreen.id);
            },
            child: Row(
            children: [
              Icon(Icons.phone_android_outlined, color: Colors.black,),
              SizedBox(width: 8,),
              Text('Continue with phone', style: TextStyle(color: Colors.black),)
            ],
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('OR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SignInButton(
          Buttons.Google,
          text: 'Continue with Google',
          onPressed: () async{
            User? user = await GoogleAuthentication.signInWithGoogle(context: context);
            if(user!=null){
              //login success
              PhoneAuthService _authentication = PhoneAuthService();
              _authentication.addUser(context, user.uid);
            }
          }
        ),
      
      ],

      ),
      
    );
  }
}