import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_tuan_flutter/manager/acm.dart';
import 'package:m_tuan_flutter/page/login_page.dart';
import 'package:m_tuan_flutter/page/main_index_page.dart';
import 'package:m_tuan_flutter/util/log.dart';
import 'package:m_tuan_flutter/util/string_util.dart';
import 'package:m_tuan_flutter/widget/scale_text_widget.dart';

void main(){

  /*强制竖屏*/
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  /*输出错误*/
  FlutterError.onError = (FlutterErrorDetails details) async {
    L.e("${details}");
  };

  start();

}

void start() async{
  bool isLogin = !StringUtils.isEmpty(await AcM.token());
  runApp(MaterialApp(
    builder: (ctx, w) {
      /*设置字体最大缩放比*/
      return MaxScaleTextWidget(
        max: 1.0,
        child: w,
      );
    },
    theme: ThemeData(
      accentColor: Colors.grey, /*滑动到底颜色*/
    ),
    home: isLogin ? MainIndexPage():LoginPage(),
  ));

}


