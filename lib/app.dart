import 'package:flutter/material.dart';
import './screens/detailScreen.dart';
import './screens/listScreen.dart';
import './screens/newPostScreen.dart';
import './screens/photoScreen.dart';


class App extends StatefulWidget{
  AppState createState() => AppState();
}

class AppState extends State<App>{

  static final routes = {
    ListScreen.routeName: (context) => ListScreen(),
    DetailScreen.routeName: (context) => DetailScreen(),
    PhotoScreen.routeName: (context) => PhotoScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen(),
  };

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      home: ListScreen(),
    );
  }
}