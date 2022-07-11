
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sell/screens/account_screen.dart';
import 'package:sell/screens/chat_screen.dart';
import 'package:sell/screens/home_screen.dart';
import 'package:sell/screens/myAd_screen.dart';
import 'package:sell/screens/sell_items/seller_category_list.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  Widget _currentScreen = HomeScreen();
  int _index = 0;
  
  final PageStorageBucket _bucket = PageStorageBucket();
  //static var locationData;
  
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
      body: PageStorage(
        bucket: _bucket, 
        child: _currentScreen
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: (){
          Navigator.pushNamed(context, SellerCategoryList.id);
        },
        
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //left side
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 0;
                        _currentScreen = HomeScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==0? Icons.home : Icons.home_outlined),
                        Text(
                          'HOME', 
                          style: TextStyle(
                            color: _index==0? color: Colors.black,
                            fontWeight: _index==0? FontWeight.bold: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 1;
                        _currentScreen = ChatScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==1? CupertinoIcons.chat_bubble_fill : CupertinoIcons.chat_bubble),
                        Text(
                          'CHATS', 
                          style: TextStyle(
                            color: _index==1? color: Colors.black,
                            fontWeight: _index==1? FontWeight.bold: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              //right side
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 2;
                        _currentScreen = MyAdsScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==2? CupertinoIcons.heart_fill : CupertinoIcons.heart),
                        Text(
                          'MY ADS', 
                          style: TextStyle(
                            color: _index==2? color: Colors.black,
                            fontWeight: _index==2? FontWeight.bold: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 3;
                        _currentScreen = AccountScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==3? CupertinoIcons.person_fill : CupertinoIcons.person),
                        Text(
                          'ACCOUNT', 
                          style: TextStyle(
                            color: _index==2? color: Colors.black,
                            fontWeight: _index==3? FontWeight.bold: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}