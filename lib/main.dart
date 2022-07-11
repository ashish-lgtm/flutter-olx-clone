import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell/forms/photo_screen.dart';
import 'package:sell/forms/seller_form.dart';
import 'package:sell/provider/cat_provider.dart';
import 'package:sell/screens/authentication/phoneauth_screen.dart';
import 'package:sell/screens/categories/category_list.dart';
import 'package:sell/screens/categories/subCat_list.dart';
import 'package:sell/screens/home_screen.dart';
import 'package:sell/screens/location_screen.dart';
import 'package:sell/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sell/screens/main_screen.dart';
import 'package:sell/screens/sell_items/seller_category_list.dart';
import 'package:sell/screens/sell_items/seller_subCat.dart';
import 'package:sell/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => CategoryProvider(),)
    ],child: MyApp(),)
    );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan.shade900,
        fontFamily: 'Lato'
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id : (context)=> SplashScreen(),
        LoginScreen.id : (context)=> LoginScreen(),
        PhoneAuthScreen.id : (context)=>PhoneAuthScreen(),
        LocationScreen.id :(context) => LocationScreen(),
        HomeScreen.id : (context)=> HomeScreen(),
        CategoryListScreen.id :(context) => CategoryListScreen(),
        SubCatList.id :(context) => SubCatList(),
        MainScreen.id :(context) => MainScreen(),
        SellerCategoryList.id :(context) => SellerCategoryList(),
        SellerSubCatList.id :(context) => SellerSubCatList(),
        SellerForm.id : (context) => SellerForm(),
        PhotoScreen.id : (context) => PhotoScreen(),
      },
    );
    /*return FutureBuilder(
      //replace the 3 second delay with initialization code
      future: Future.delayed(Duration(seconds:3)),
      builder: (context, AsyncSnapshot snapshot){
        //show splash screen while waiting for app resources tp load:
        if(snapshot.connectionState == ConnectionState.waiting){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Colors.cyan.shade900,
                fontFamily: 'Lato'
            ),
            home: SplashScreen());
        }
          else{
            //loading is done, return the app
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.cyan.shade900,
                fontFamily: 'Lato'
              ),
              // need to change this to initial screen meaning starting screen
              home: LoginScreen(),
              routes: {
                //adding screens here for easy navigation
                LoginScreen.id : (context)=> LoginScreen(),
                PhoneAuthScreen.id : (context)=>PhoneAuthScreen(),
                LocationScreen.id : (context)=> LocationScreen(),
              },
            );
          }
        },
    );
    */
  }
}