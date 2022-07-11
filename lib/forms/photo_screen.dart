
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sell/provider/cat_provider.dart';

class PhotoScreen extends StatefulWidget {
  static const String id = 'photo-screen';

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  File? _image;
  bool _uploading = false;
  final picker = ImagePicker();

  Future getImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState((){
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else{
        print('No image selected');
      }

    });
  }
  @override
  Widget build(BuildContext context) {

    var _provider = Provider.of<CategoryProvider>(context);

    //image upload to storage
    Future<String?> uploadFile() async{
      File file = File(_image!.path);
      String imageName = 'productImage/${DateTime.now().microsecondsSinceEpoch}';
      String? downloadUrl;
      try{
        await FirebaseStorage.instance
         .ref(imageName) //file name to save in storage
         .putFile(file);
        downloadUrl = await FirebaseStorage.instance
         .ref(imageName)
         .getDownloadURL();
        // ignore: unnecessary_null_comparison
        if(downloadUrl!=null)
         setState(() {
          _image = null;
          //print(downloadUrl); 
          //add uploaded url to list
          _provider.getImages(downloadUrl);
         });
      } on FirebaseException{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cancelled')),
        );

      }
      return downloadUrl;
    }

    print(_provider.urlList.length);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text('Upload photo', style: TextStyle(color: Colors.black),),
        shape: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                child: _image == null ? Icon(
                  CupertinoIcons.photo_on_rectangle,
                  color: Colors.grey,
                ): Image.file(_image!),
              ),
            ),

            SizedBox(height: 20,),
            if(_provider.urlList.length>0)
             Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
              child: GalleryImage(
                imageUrls: _provider.urlList,
                numOfShowImages: _provider.urlList.length<=3 ?_provider.urlList.length-1 : 3,          
              )
             ),
            SizedBox(height: 20,),
            if(_image!=null)
             Row(
              children: [
                Expanded(
                  child: NeumorphicButton(
                    style: NeumorphicStyle(color: Colors.green),
                    onPressed: (){
                      setState(() {
                        _uploading = true;
                        uploadFile().then((url){
                          setState(() {
                            _uploading = false;
                          });

                        });
                      });
                    },
                    child: Text('Save', textAlign: TextAlign.center,),
                )),
                SizedBox(width: 10,),
                Expanded(
                  child: NeumorphicButton(
                    style: NeumorphicStyle(color: Colors.red),
                    onPressed: (){},
                    child: Text('Cancel', textAlign: TextAlign.center,),
                )),
              ],
             ),
            SizedBox(height: 20,),
            
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,20.0),
                    child: NeumorphicButton(
                      onPressed: getImage,
                      style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                      child: Text(
                        _provider.urlList.length>0 ? 'Upload more images' : 'Upload image',
                        textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            if(_uploading)
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            )
          ],
          ),
      ),
      
    );
  }
}