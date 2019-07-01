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

  CContainer({Key key,this.child, this.width,this.height,this.expand, this.flex, this.color, this.borderColor,
    this.borderWidth, this.borderRadius, this.leftTopBorderRadius,
    this.rightTopBorderRadius, this.leftBottomBorderRadius,
    this.rightBottomBorderRadius, this.padding, this.margin, this.alignment,
    this.direction,this.children,this.gradient,this.boxShadow,
    this.mainAxisAlignment,this.mainAxisSize,this.crossAxisAlignment,
    this.onTap, this.onLongPress}): super(key: key);

  @override
  Widget build(BuildContext context) {
    expand = expand ?? false;
    flex = flex ?? 1;

    if(expand) return Expanded(child: getContainerWidget(),flex: flex,);
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
    if(direction == Direction.row) child = Row(children: children,mainAxisAlignment: mainAxisAlignment,mainAxisSize: mainAxisSize,crossAxisAlignment: crossAxisAlignment);
    if(direction == Direction.column) child = Column(children: children,mainAxisAlignment: mainAxisAlignment,mainAxisSize: mainAxisSize,crossAxisAlignment: crossAxisAlignment);

    return GestureDetector(
      child: Container(
        child: child,
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        alignment: alignment,
        decoration: BoxDecoration(
            color: gradient != null ? null:color, /*有渐变属性的话color要传null*/
            gradient: gradient,
            border: Border.all(color: borderColor,width: borderWidth),
            boxShadow: boxShadow == null ? null:[boxShadow],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(leftTopBorderRadius),
                topRight: Radius.circular(rightTopBorderRadius),
                bottomLeft: Radius.circular(leftBottomBorderRadius),
                bottomRight: Radius.circular(rightBottomBorderRadius),
            ),
        ),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

}


