import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_tuan_flutter/page/main_index_page.dart';
import 'package:m_tuan_flutter/util/log.dart';

void main(){

  /*强制竖屏*/
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  FlutterError.onError = (FlutterErrorDetails details) async {
    L.e("${details}");
  };

  runApp(MainIndexPage());

}


