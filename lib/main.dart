import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_tuan_flutter/conts/conts.dart';
import 'package:m_tuan_flutter/page/main_index_page.dart';

void main(){

  /*强制竖屏*/
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(MainIndexPage());

}


