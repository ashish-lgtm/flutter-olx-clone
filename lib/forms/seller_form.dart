
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:provider/provider.dart';
import 'package:sell/forms/photo_screen.dart';
import 'package:sell/provider/cat_provider.dart';

class SellerForm extends StatefulWidget {
  static const String id = 'form';

  @override
  State<SellerForm> createState() => _SellerFormState();
}

class _SellerFormState extends State<SellerForm> {
  final _formKey = GlobalKey<FormState>();

  var _titleController = TextEditingController();
  var _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var _catprovider = Provider.of<CategoryProvider>(context);
    validate(CategoryProvider provider){
    if(_formKey.currentState!.validate()){
      //if all fields are filled
      if(provider.urlList.isNotEmpty){
        //should have image
        provider.dataToFirestore.addAll({
          'category' : provider.selectedCategory,
          'title' : _titleController.text,
          'description' : _descController.text,
          'images' : [provider.urlList],
        });
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete required fields'),
        ),
      );
    }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text('Add some details', style: TextStyle(color: Colors.black),),
        shape: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Ad title*',
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please complete required field';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Describe what you are selling*',
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please complete required field';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Price*',
                    prefixText: 'Rs '
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please complete required field';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                if(_catprovider.urlList.length>0)
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: GalleryImage(
                    imageUrls: _catprovider.urlList,
                    numOfShowImages: _catprovider.urlList.length<=3 ?_catprovider.urlList.length-1 : 3,          
                  )
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    _catprovider.urlList.length>0? 'Upload images': 'Upload image',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    ),),
                ),
                onPressed: (){
                  //validate();
                  Navigator.pushNamed(context, PhotoScreen.id);
                },
              ),
              
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    ),),
                ),
                onPressed: (){
                  validate(_catprovider);
                  print(_catprovider.dataToFirestore);
                },
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}