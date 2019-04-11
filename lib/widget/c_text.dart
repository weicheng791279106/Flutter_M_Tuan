import 'package:flutter/material.dart';

class CText extends StatelessWidget{

  String s;
  TextAlign textAlign;
  int maxLines;
  Color textColor;
  double textSize;
  bool bold;
  EdgeInsetsGeometry margin;
  EdgeInsetsGeometry padding;

  CText(this.s, {this.textAlign, this.maxLines, this.textColor, this.textSize,
      this.bold,this.margin,this.padding});

  @override
  Widget build(BuildContext context) {
    if(margin == null && padding == null)
      return getContainerWidget();

    /*需要padding或者margin*/
    return Container(
      margin: margin,
      padding: padding,
      child: getContainerWidget(),
    );
  }

  Widget getContainerWidget(){
    textAlign = textAlign ?? TextAlign.start;
    bold = bold ?? false;
    textSize = textSize ?? 12;
    textColor = textColor ?? Colors.black;

    return new Text(s,
        textAlign: textAlign,
        maxLines: maxLines,
        style: new TextStyle(
          color: textColor,
          fontSize: textSize,
          fontWeight: bold ? FontWeight.w500 : FontWeight.normal,
        )
    );
  }

}