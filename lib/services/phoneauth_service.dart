import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sell/screens/authentication/otp_screen.dart';
import 'package:sell/screens/location_screen.dart';

class PhoneAuthService{
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  
  Future<void> addUser(context,uid) async{

      // check user data exists in firestore or not

      final QuerySnapshot result = await users.where('uid', isEqualTo: user?.uid).get();
      List <DocumentSnapshot> document = result.docs;//list of user data

      if(document.length>0){
        //user data exists
        //skip adding again in firestore
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      }
      else{
        //add user data to firestore
        return users.doc(user!.uid)
          .set({
            'uid': user!.uid, // user id
            'mobile': user!.phoneNumber, 
            'email': user!.email 
          })
          .then((value){
            //add data to firebase then will go to next screen
            Navigator.pushReplacementNamed(context, LocationScreen.id);
          })
          .catchError((error){
            print("Failed to add user: $error");
          });
    }
      }
      

  Future<void>verifyPhoneNumber(BuildContext context, number) async{
    final PhoneVerificationCompleted verificationCompleted = 
      (PhoneAuthCredential credential) async{
        // automattic login with real no
        await auth.signInWithCredential(credential); //after verification completec need to signin
      };
  

  final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e){
    // if verification failed it will show the reason
    if(e.code == 'invalid-phone-number'){
      print('The provided phone number is not valid.');
    }
    print('The errors is ${e.code}');
  };

  final PhoneCodeSent codeSent = (String verId, int? resendToken)async{
    // if OTP sent then new screen opens
    Navigator.push(
      context, MaterialPageRoute(builder: (context)=>OTPScreen(number: number,verId: verId,),),);

  };

  try{
    auth.verifyPhoneNumber(
      phoneNumber: number, 
      verificationCompleted: verificationCompleted, 
      verificationFailed: verificationFailed, codeSent: codeSent, 
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId){
        print(verificationId);
      });
    }catch(e){
      print('Error ${e.toString()}');
    }

  }
}