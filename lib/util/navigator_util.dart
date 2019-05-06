import 'package:flutter/widgets.dart';

/**
 * 转场工具类
 * */
class NavigatorUtil{

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