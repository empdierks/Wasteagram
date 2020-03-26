import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'newPostScreen.dart';

class PhotoScreen extends StatefulWidget{

  static const routeName = 'photo_screen';
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen>{

  File image;
  String photoURL;

  Future getImage() async{
    image = await ImagePicker.pickImage(source: ImageSource.gallery);

    var dateStamp = DateFormat("yyyyMMdd'T'HHmmss");
    String currentDate = dateStamp.format(DateTime.now());

    StorageReference storageReference = FirebaseStorage.instance.ref().child('$currentDate.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    photoURL = await storageReference.getDownloadURL();
    print(photoURL);
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) =>
        NewPostScreen(url: photoURL)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Wasteagram'),
        ),
        body: Center(
            child: photoSelection(context)

        )
    );
  }

  Widget photoSelection(BuildContext context){
    if(image == null){
      return Center(
            child: Semantics(
                button: true,
                enabled: true,
                onTapHint: 'Select an Image',
                child: RaisedButton(
                    child:Text('Select Photo'),
                    onPressed: () {
                      getImage();
                    }
                )
            )
      );
    } else{
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(image),
              SizedBox(height: 40),
              RaisedButton(
                child: Text('Submit'),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewPostScreen(url: photoURL),
                      )
                  );
                }
              )
            ],
        )
      );
    }
  }
}