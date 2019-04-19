import 'package:flutter/material.dart';

class CImage extends StatelessWidget{

  String url;
  String asset;
  double heiget;
  double width;
  BoxFit fit;
  double scale;

  double borderRadius;
  double leftTopRadius;
  double leftBottomRadius;
  double rightTopRadius;
  double rightBottomRadius;


  CImage({this.url, this.asset, this.heiget, this.width,this.fit = BoxFit.fill,
    this.borderRadius = 0,
    this.leftTopRadius,
    this.leftBottomRadius,
    this.rightTopRadius,
    this.rightBottomRadius,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    if(borderRadius != null || leftTopRadius != null || leftBottomRadius != null || rightTopRadius != null || rightBottomRadius > 0)
      return SizedBox(width: width,height: heiget,child: borderWidget());

    return SizedBox(width: width,height: heiget,child: getChild());
  }

  Widget borderWidget(){
    leftTopRadius = leftTopRadius ?? borderRadius;
    leftBottomRadius = leftBottomRadius ?? borderRadius;
    rightTopRadius = rightTopRadius ?? borderRadius;
    rightBottomRadius = rightBottomRadius ?? borderRadius;
    return ClipRRect(
      child: getChild(),
      borderRadius:BorderRadius.only(
        topLeft: Radius.circular(leftTopRadius),
        topRight: Radius.circular(rightTopRadius),
        bottomLeft: Radius.circular(leftBottomRadius),
        bottomRight: Radius.circular(rightBottomRadius)
      )
    );
  }

  Widget getChild(){
    if(url != null) return Image.network(url,fit: fit,scale: scale,);
    if(asset != null) return Image.asset(asset,fit: fit,scale: scale,);
  }

}