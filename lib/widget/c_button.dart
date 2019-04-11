import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';

class CButton extends StatelessWidget{

  String text;
  Color textColor;
  double textSize;
  Color color;
  bool bold;
  bool expand;
  int flex;
  Color borderColor;
  double borderWidth;
  double borderRadius;
  double leftTopBorderRadius;
  double rightTopBorderRadius;
  double leftBottomBorderRadius;
  double rightBottomBorderRadius;
  EdgeInsetsGeometry padding;
  VoidCallback onPressed;

  CButton(this.text, {this.textColor, this.textSize, this.color, this.bold,
      this.expand, this.flex, this.borderColor, this.borderWidth,
      this.borderRadius, this.leftTopBorderRadius, this.rightTopBorderRadius,
      this.leftBottomBorderRadius, this.rightBottomBorderRadius, this.padding,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    expand = expand ?? false;
    flex = flex ?? 1;

    if(expand) return new Expanded(child: getContainerWidget(),flex: flex);
    return getContainerWidget();
  }

  Widget getContainerWidget(){
    leftTopBorderRadius = leftTopBorderRadius ?? (borderRadius ?? 0);
    rightTopBorderRadius = rightTopBorderRadius ?? (borderRadius ?? 0);
    leftBottomBorderRadius = leftBottomBorderRadius ?? (borderRadius ?? 0);
    rightBottomBorderRadius = rightBottomBorderRadius ?? (borderRadius ?? 0);

    color = color ?? Colors. blue;
    borderColor = borderColor ?? Colors.transparent;
    borderWidth = borderWidth ?? 0;

    return FlatButton(
      onPressed: onPressed ?? () => {},
      color:color,
      padding: padding,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor,width: borderWidth),
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(leftTopBorderRadius),
            topRight:Radius.circular(rightTopBorderRadius),
            bottomLeft:Radius.circular(leftBottomBorderRadius),
            bottomRight:Radius.circular(rightBottomBorderRadius),
          )
      ),
      child: CText(
          text,
          textColor: textColor,
          textSize: textSize,
          bold: bold,
          textAlign: TextAlign.center,
          maxLines: 1,
      ),
    );
  }

}















