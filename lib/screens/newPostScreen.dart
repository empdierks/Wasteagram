import 'package:flutter/material.dart';
import '../widgets/newPostForm.dart';

class NewPostScreen extends StatefulWidget{

  static const routeName = 'new_post_screen';
  String url;
  NewPostScreen({Key key, this.url}): super(key: key);

  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wasteagram'),
      ),
      body:LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints){
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[NewPostForm(url: widget.url)]
                  )
              )
          )
      );
    }
    )
    );
  }

}