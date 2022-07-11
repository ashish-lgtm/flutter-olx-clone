
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sell/screens/main_screen.dart';


class LocationScreen extends StatefulWidget {
  static const String id = 'location-screen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  bool _loading = false;

  Location location = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<LocationData?> getLocation()async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  
  _locationData = await location.getLocation();
  

  print(_locationData);

  return _locationData;
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/location.png',
            ),
            SizedBox(
              height:20,
              ),
            Text(
              'Location',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _loading? Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            )):ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor),
                ),
              onPressed: (){
                setState(() {
                  _loading = true;
                });
                getLocation().then((value) {
                  print(_locationData.latitude);
                  print(_locationData.longitude);
                  if(value!=null){
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(
                      builder: (BuildContext context)=> MainScreen(),),);
                }
                });
              }, 
              icon: Icon(CupertinoIcons.location_fill), label: Text('Fetch location',),
              ),
          ],
          ),
      ),
    );
    
  }
}