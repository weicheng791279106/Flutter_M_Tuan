import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/text_size.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';

enum DrawableDirection{
  top,left,right,bottom,
}

class CText extends StatelessWidget{

  String s;
  TextAlign textAlign;
  int maxLines;
  Color textColor;
  Color color;
  double textSize;
  bool bold;
  TextDecoration decoration;
  EdgeInsetsGeometry margin;
  EdgeInsetsGeometry padding;

  IconData icon;
  String imageAsset;
  DrawableDirection drawableDirection;
  double drawablePadding;
  double imageHeight;
  double imageWidth;
  double iconSize;
  double imageScale;
  double lineHeight;


  CText(this.s, {this.textAlign, this.maxLines, this.textColor,this.color, this.textSize,
      this.bold,this.margin,this.padding,this.decoration,this.lineHeight,
      this.icon,this.imageAsset,this.drawableDirection,this.drawablePadding,this.imageWidth,this.imageHeight,this.iconSize,this.imageScale});

  @override
  Widget build(BuildContext context) {
    textAlign = textAlign ?? TextAlign.start;
    bold = bold ?? false;
    textSize = textSize ?? TextSize.Normal;
    textColor = textColor ?? Colors.black;

    drawableDirection = drawableDirection ?? DrawableDirection.right;
    drawablePadding = drawablePadding ?? 0;

    /*没有特殊要求*/
    if(margin == null && padding == null && icon == null && imageAsset == null && color == null)
      return getContainerWidget();

    /*没有附带图标要求，但是需要padding或者margin*/
    if(icon == null && imageAsset == null)
      return Container(
        color: color,
        margin: margin,
        padding: padding,
        child: getContainerWidget(),
      );

    /*需要附带图标要求*/
    return CContainer(
      color: color,
      margin: margin,
      padding: padding,
      mainAxisSize: MainAxisSize.min,
      direction: drawableDirection == DrawableDirection.left || drawableDirection == DrawableDirection.right ? Direction.row:Direction.column,
      children: getChildrenWidget(),
    );
  }

  List<Widget> getChildrenWidget(){
    List<Widget> children = new List();
    if(drawableDirection == DrawableDirection.left || drawableDirection == DrawableDirection.top){
      children.add(getImageWidget());
      /*加入drawablePadding*/
      if(drawableDirection == DrawableDirection.left || drawableDirection == DrawableDirection.right) children.add(SizedBox(width: drawablePadding));
      if(drawableDirection == DrawableDirection.top || drawableDirection == DrawableDirection.bottom) children.add(SizedBox(height: drawablePadding));
      children.add(getContainerWidget());
    }else{
      children.add(getContainerWidget());
      /*加入drawablePadding*/
      if(drawableDirection == DrawableDirection.left || drawableDirection == DrawableDirection.right) children.add(SizedBox(width: drawablePadding));
      if(drawableDirection == DrawableDirection.top || drawableDirection == DrawableDirection.bottom) children.add(SizedBox(height: drawablePadding));
      children.add(getImageWidget());
    }
    return children;
  }

  Widget getImageWidget(){
    if(icon != null) return Icon(icon,color: textColor,size: iconSize);
    if(imageAsset != null) return CImage(asset: imageAsset,width: imageWidth,heiget: imageHeight,scale: imageScale,);
  }

  Widget getContainerWidget(){
    return new Text(s ?? "",
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: true,
        style: new TextStyle(
          height: lineHeight,
          color: textColor,
          fontSize: textSize,
          fontWeight: bold ? FontWeight.w500 : FontWeight.normal, decoration: decoration ?? TextDecoration.none,
        )
    );
  }

}