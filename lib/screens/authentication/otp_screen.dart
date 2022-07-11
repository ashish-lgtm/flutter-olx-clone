import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sell/screens/authentication/phoneauth_screen.dart';
import 'package:sell/services/phoneauth_service.dart';

class OTPScreen extends StatefulWidget {
  final String number,verId;
  OTPScreen({required this.number,required this.verId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  bool _loading = false;
  String error='';

  PhoneAuthService _services = PhoneAuthService();

  var _text1 = TextEditingController();
  var _text2 = TextEditingController();
  var _text3 = TextEditingController();
  var _text4 = TextEditingController();
  var _text5 = TextEditingController();
  var _text6 = TextEditingController();

  Future<void>phoneCredential(BuildContext context, String otp,)async{

    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verId, smsCode: otp);
      //need to otp validated or not
      final User? user = (await _auth.signInWithCredential(credential)).user;

      if(user != null){
        //signed in
        _services.addUser(context,user.uid);
        
      }
      else{
        print('Login Failed');
        setState(() {
          error = 'Login Failed';
        });
      }
    }catch(e){
      print(e.toString());
      if(mounted){
        setState(() {
          error = 'Invalid OTP';
        });
      }
      
    }

  }


  @override
  Widget build(BuildContext context) {


    final node = FocusScope.of(context);


    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text('Login', style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: false, //to remove back screen
        ),
        body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red.shade200,
              child: Icon(CupertinoIcons.person_alt_circle,
              color: Colors.red,
              size: 60,
              ),
            ),
            SizedBox(height: 12,),
            Text('Welcome Back',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'We sent a 6-digit code to ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: widget.number,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                    
                  ),
                ),
                InkWell(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>PhoneAuthScreen(),),); //it will go back to previous screen
                },
                child: Icon(Icons.edit)
                ),
              ],
            ),
            SizedBox(height: 12,),
            Row(children: [
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _text1,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    if(value.length==1){
                      node.nextFocus();
                    }
                  },
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _text2,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    if(value.length==1){
                      node.nextFocus();
                    }
                  },
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _text3,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    if(value.length==1){
                      node.nextFocus();
                    }
                  },
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _text4,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    if(value.length==1){
                      node.nextFocus();
                    }
                  },
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _text5,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    if(value.length==1){
                      node.nextFocus();
                    }
                  },
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _text6,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    if(value.length==1){
                      if(_text1.text.length == 1)
                       if(_text2.text.length == 1)
                         if(_text3.text.length == 1)
                           if(_text4.text.length == 1)
                             if(_text5.text.length == 1){
                               // otp received
                               String _otp = '${_text1.text}${_text2.text}${_text3.text}${_text4.text}${_text5.text}${_text6.text}';
                               setState(() {
                                 _loading = true;
                               });

                               //login
                               phoneCredential(context, _otp);
                             }
                               
                    }else{
                      setState(() {
                        _loading = false;
                      });
                    }
                  },
                ),
              ),
              
              
            ],
            ),
            SizedBox(height: 18,),
            if(_loading)
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 50,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                ),
              ),
              SizedBox(height: 18,),
              //need to show if any error
              Text(error,style: TextStyle(color: Colors.red,fontSize: 12),)
          ],
        ),
      ),
      
    );
  }
}