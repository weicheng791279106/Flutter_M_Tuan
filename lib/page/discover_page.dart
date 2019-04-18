import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';

class DiscoverPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return DiscoverPageState();
  }

}

class DiscoverPageState extends State<DiscoverPage> {

  @override
  Widget build(BuildContext context) {
    return CContainer(
      alignment: Alignment.center,
      color: Colors.white,
      child: CText("发现"),
    );
  }

}