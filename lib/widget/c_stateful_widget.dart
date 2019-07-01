import 'package:flutter/widgets.dart';

/**
 * 自定义StatefulWidget，写起来方便点
 * */
// ignore: mixin_inherits_from_not_object
abstract class CStatefulWidget extends _Stateful with State<StatefulWidget> {

  @override
  State<StatefulWidget> createState() => this;

  refresh() => setState(() {});

}

abstract class _Stateful extends StatefulWidget {}
