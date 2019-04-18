import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';

class MinePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }

}

class MinePageState extends State<MinePage> {

  @override
  Widget build(BuildContext context) {
    return CContainer(
      alignment: Alignment.center,
      color: Colors.white,
      child: CText("我的"),
    );
  }

}