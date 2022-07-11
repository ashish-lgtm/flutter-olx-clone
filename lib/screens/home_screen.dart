import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sell/widgets/banner_widget.dart';
import 'package:sell/widgets/category_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  //final LocationData locationData;
  //HomeScreen({required this.locationData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  /*String address = 'India';

  Future<String> getAddress()async{
    final coordinates = new Coordinates(1.10, 45.50);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    setState(() {
      address = first.addressLine;
    });
    return first.addressLine;

  }*/
  String address = ""; // create this variable

  void getAddress() async {
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> newPlace = await placemarkFromCoordinates(position.latitude, position.longitude);

    // this is all you need
    Placemark placeMark  = newPlace[0]; 
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    String _address = "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";
    
    print(_address);

    setState(() {
      address = _address; // update address
    });
  }

  @override
  void initState(){
    getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(CupertinoIcons.location_solid,color:Colors.black,size: 18,),
              Flexible(
                child: Text(
                  address,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                ),
              ),
              Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,)
            ],
          ),
        ),
      ),
      /*body: Center(
        child: ElevatedButton(
          child: Text('Sign Out'),
          onPressed: (){
            FirebaseAuth.instance.signOut().then((value){
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            });
          },),),*/
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16,6,16,8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          labelText: 'Search products',
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.only(left: 10,right: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))
                        ),
                                      
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.notifications_none),
                  SizedBox(width: 10,),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,8),
            child: Column(
              children: [
                BannerWidget(),
                CategoryWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

  
  

  

 