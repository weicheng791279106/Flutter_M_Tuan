import 'package:flutter/material.dart';

class MainIndexPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return MainIndexPageState();
  }

}

class MainIndexPageState extends State<MainIndexPage>{

  @override
  Widget build(BuildContext context) {
    return Center(child:Text("仿美团 Flutter",textDirection: TextDirection.ltr,));
  }

}