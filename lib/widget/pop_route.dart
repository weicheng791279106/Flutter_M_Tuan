import 'package:flutter/widgets.dart';

/**
 * 实现任意位置dialog
 *
 * 使用方法：Navigator.push(context, PopRoute(child: XXX_Widget));
 * 退出直接：Navigator.pop(context);
 * */
class PopRoute extends PopupRoute{

  final Duration _duration = Duration(milliseconds: 0);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;

}