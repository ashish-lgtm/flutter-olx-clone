
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sell/services/firebase_services.dart';

class SellerSubCatList extends StatelessWidget {
  static const String id = 'seller-subCat-screen';

  @override
  Widget build(BuildContext context) {

    FirebaseService _service = FirebaseService();

    DocumentSnapshot? args = ModalRoute.of(context)!.settings.arguments as DocumentSnapshot<Object?>?;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        shape: Border(bottom: BorderSide(color: Colors.grey),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(args!['catName'], style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        child: FutureBuilder<DocumentSnapshot>(
        future: _service.categories.doc(args.id).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }

          var data = snapshot.data!['subCat'];

          return Container(
            child: ListView.builder(
              
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index){
               
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      //sub categories
                      
                    },
                    
                    title: Text(data[index],),
                    
                  ),
                );
                
              },
            ),
          );
        },
      ),
      ),
    );
  }
}