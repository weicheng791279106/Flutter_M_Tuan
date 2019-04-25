import 'package:flutter/material.dart';

enum Direction{
  row, column,
}

class CContainer extends StatelessWidget{

  Widget child;
  bool expand;
  double width;
  double height;
  int flex;
  Color color;
  Color borderColor;
  double borderWidth;
  double borderRadius;
  double leftTopBorderRadius;
  double rightTopBorderRadius;
  double leftBottomBorderRadius;
  double rightBottomBorderRadius;
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry margin;
  AlignmentGeometry alignment;
  Gradient gradient;
  BoxShadow boxShadow;

  Direction direction;
  List<Widget> children;
  MainAxisAlignment mainAxisAlignment ;
  MainAxisSize mainAxisSize ;
  CrossAxisAlignment crossAxisAlignment ;

  GestureTapCallback onTap;
  GestureLongPressCallback onLongPress;

  CContainer({this.child, this.width,this.height,this.expand, this.flex, this.color, this.borderColor,
    this.borderWidth, this.borderRadius, this.leftTopBorderRadius,
    this.rightTopBorderRadius, this.leftBottomBorderRadius,
    this.rightBottomBorderRadius, this.padding, this.margin, this.alignment,
    this.direction,this.children,this.gradient,this.boxShadow,
    this.mainAxisAlignment,this.mainAxisSize,this.crossAxisAlignment,
    this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    expand = expand ?? false;
    flex = flex ?? 1;

    if(width != null || height != null) return SizedBox(width: width,height: height,child: getContainerWidget(),);
    if(expand) return new Expanded(child: getContainerWidget(),flex: flex,);
    return getContainerWidget();
  }

  Widget getContainerWidget(){
    leftTopBorderRadius = leftTopBorderRadius ?? (borderRadius ?? 0);
    rightTopBorderRadius = rightTopBorderRadius ?? (borderRadius ?? 0);
    leftBottomBorderRadius = leftBottomBorderRadius ?? (borderRadius ?? 0);
    rightBottomBorderRadius = rightBottomBorderRadius ?? (borderRadius ?? 0);

    mainAxisAlignment = mainAxisAlignment ?? MainAxisAlignment.start;
    mainAxisSize = mainAxisSize ?? MainAxisSize.max;
    crossAxisAlignment = crossAxisAlignment ?? CrossAxisAlignment.center;

    color = color ?? Colors.transparent;
    borderColor = borderColor ?? Colors.transparent;
    borderWidth = borderWidth ?? 0;

    Widget child = this.child;
    if(direction == Direction.row) child = new Row(children: children,mainAxisAlignment: mainAxisAlignment,mainAxisSize: mainAxisSize,crossAxisAlignment: crossAxisAlignment);
    if(direction == Direction.column) child = new Column(children: children,mainAxisAlignment: mainAxisAlignment,mainAxisSize: mainAxisSize,crossAxisAlignment: crossAxisAlignment);

    return new GestureDetector(
      child: new Container(
        child: child,
        padding: padding,
        margin: margin,
        alignment: alignment,
        decoration: new BoxDecoration(
            color: gradient != null ? null:color, /*有渐变属性的话color要传null*/
            gradient: gradient,
            border: new Border.all(color: borderColor,width: borderWidth),
            boxShadow: boxShadow == null ? null:[boxShadow],
            borderRadius: new BorderRadius.only(
                topLeft: new Radius.circular(leftTopBorderRadius),
                topRight: new Radius.circular(rightTopBorderRadius),
                bottomLeft: new Radius.circular(leftBottomBorderRadius),
                bottomRight: new Radius.circular(rightBottomBorderRadius),
            ),
        ),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

}


