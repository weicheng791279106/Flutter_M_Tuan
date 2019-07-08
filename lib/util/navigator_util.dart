import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/**
 * 转场工具类
 * */
class NavigatorUtil{

  /**打开新页面并关闭当前页*/
  static void pushAndClose(BuildContext context,Widget pageWidget){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => pageWidget
        ), (route) => route == null
    );
  }

  /**带动画进入*/
  static void pushWithAnimation(BuildContext context,Widget pageWidget){
    Navigator.push<String>(
        context,
        new PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return pageWidget;
            },
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child,){
              return createTransition(animation, child);
            }
        )
    );
  }

  static void push(BuildContext context,Widget pageWidget){
    Navigator.push(context, new MaterialPageRoute(builder: (context) => pageWidget),);
  }

  static SlideTransition createTransition(Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }

}