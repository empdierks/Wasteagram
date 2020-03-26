import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detailScreen.dart';
import 'photoScreen.dart';


class ListScreen extends StatefulWidget{

  static const routeName = 'list_screen';
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen>{

  int totalWaste = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: StreamBuilder(
          stream: Firestore.instance.collection('post').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return Text('Wastegram');
            else{
              for(int index = 0; index < snapshot.data.documents.length; index++){
                totalWaste = getTotalWaste(snapshot.data.documents[index]['quantity'], totalWaste);
              }
              int wasteTotal = totalWaste; //Ensures that it doesn't double values when reloads
              totalWaste = 0;
            return Text('Wasteagram - $wasteTotal');
            }
          }
        ),
      ),
        floatingActionButton: Semantics(
          button: true,
          onTapHint: 'Add a New Post',
          child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                Navigator.of(context).pushNamed(PhotoScreen.routeName);
              }
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: Firestore.instance.collection('post').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else{
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, snapshot.data.documents[index]),
                  ),
                )
              ]
            );
          }
        }
      )
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              document['date'],
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffddddff),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              document['quantity'].toString(),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ]
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(document: document)
          )
        );
      }
    );
  }

  int getTotalWaste(int quantity, int totalWaste){
    return totalWaste = totalWaste + quantity;
  }
}