import 'package:flutter/material.dart';

class CCircleAvatar extends StatelessWidget{

  Color loadingColor;
  String url;
  double width;
  double height;

  CCircleAvatar(this.url,{this.loadingColor,this.width, this.height});

  @override
  Widget build(BuildContext context) {
    width = width ?? 45;
    height = height ?? 45;
    loadingColor = loadingColor ?? Colors.grey[100];
    url = url ?? "";

    return new SizedBox.fromSize(
        size: new Size(width, height),
        child: new CircleAvatar(
            backgroundColor:loadingColor,
            backgroundImage: new NetworkImage(url)
        )
    );
  }

}