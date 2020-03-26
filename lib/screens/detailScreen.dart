import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget{

  static const routeName = 'detail_screen';
  DocumentSnapshot document;

  DetailScreen({Key key, @required this.document}): super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wasteagram'),
      ),
      body: Center(
        child: Column(
            children: [
              Text(document['date'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
              Container(
                height: 300.0,
                width: 300.0,
                child: Image.network(document['imageURL'])
              ),
              Text('Items: ${document['quantity']}', style: TextStyle(fontSize: 20.0)),
              Text('( ${document['latitude']} , ${document['longitude']} )', style: TextStyle(fontSize: 20.0)),
            ]
        )
      )
    );
  }
}