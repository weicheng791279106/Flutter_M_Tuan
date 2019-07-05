import 'package:flutter/services.dart';

class L {
  static const perform = const MethodChannel("android_log");

  static void i(String message,{String tag}) {
    perform.invokeMethod('logI', {'tag': tag??"see", 'msg': message});
  }

  static void e(String message,{String tag}) {
    perform.invokeMethod('logE', {'tag': tag??"error", 'msg': message});
  }

  static void json(String json){
    perform.invokeMethod('logJSON',{'msg': json});
  }

}