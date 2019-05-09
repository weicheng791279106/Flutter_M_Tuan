import 'package:flutter/widgets.dart';

class ViewUtil{

  static Offset getViewLocation(GlobalKey globalKey){
    return (globalKey.currentContext.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
  }

  static Size getViewSize(GlobalKey globalKey){
    return (globalKey.currentContext.findRenderObject() as RenderBox).size;
  }

}