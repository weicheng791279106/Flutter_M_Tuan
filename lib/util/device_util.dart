import 'package:flutter/widgets.dart';

class DeviceUtil{

  static double getScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static double getStatusBarHeight(BuildContext context){
    return MediaQuery.of(context).padding.top;
  }

  static double getNavigationHeight(BuildContext context){
    return MediaQuery.of(context).padding.bottom;
  }

}