

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sell/screens/categories/category_list.dart';
import 'package:sell/services/firebase_services.dart';


class CategoryWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    FirebaseService _service = FirebaseService();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<QuerySnapshot>(
        future: _service.categories.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          return Container(
            height: 200,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text('Categories')),
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, CategoryListScreen.id);
                      }, 
                      child: Row(
                        children: [
                          Text('See all',style: TextStyle(color: Colors.black),),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index){
                      var doc = snapshot.data?.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 60,
                          height: 50,
                          child: Column(
                            children: [
                              Image.network(doc!['image']),
                              Flexible(
                                child: Text(
                                  doc['catName'],
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 10),),
                              ),
                            ],
                          ),
                        ),
                      );
                      
                    },
                  ),
                ),
              ],
            ),

          );
        },
      ),
    );
  }
}