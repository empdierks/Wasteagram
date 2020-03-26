import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import '../models/post.dart';
import '../screens/listScreen.dart';

class NewPostForm extends StatefulWidget{

  String url;
  NewPostForm({Key key, this.url}): super(key: key);

  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm>{

  final formKey = GlobalKey<FormState>();
  LocationData locationData;
  Post post = Post();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async{
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState( () {} );
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            displayPhoto(),
            SizedBox(height: 5),
            numItems(),
            SizedBox(height: 5),
            uploadButton(context),
          ]
        )
      )
    );
  }

  Widget displayPhoto(){
    return Center(
        child: Image.network(widget.url),
    );
  }

  Widget numItems(){
    return TextFormField(
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Quantity of Items',
        border: OutlineInputBorder(),
      ),
      onSaved: (value){
        post.quantity = int.parse(value);
      },
      validator: (value){
        if(value.isEmpty){
          return 'Please enter a Quantity';
        } else{
          return null;
        }
      },
    );
  }

  void addLocation(){
      post.latitude = locationData.latitude;
      post.longitude = locationData.longitude;
  }

  void addDate(){
    var date = DateFormat.yMMMEd('en_US').format(DateTime.now());
    post.date = date;
  }


  Widget uploadButton(BuildContext context){
      return Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Upload Quantity of Waste and Photo',
        child: RaisedButton(
            child: Text('Upload'),
            onPressed: () async{
              if(formKey.currentState.validate()){
                formKey.currentState.save();
                addLocation();
                addDate();
                //save to FireStore
                Firestore.instance.collection('post').document().setData({
                  'date': post.date,
                  'latitude': post.latitude,
                  'longitude': post.longitude,
                  'quantity': post.quantity,
                  'imageURL': widget.url,
                });
                Navigator.of(context).pushNamedAndRemoveUntil(ListScreen.routeName, (_) => false); //prevents from going back to form
              }
            }
        )
      );
  }

}

