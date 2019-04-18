import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';

class OrderPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return OrderPageState();
  }

}

class OrderPageState extends State<OrderPage> {

  @override
  Widget build(BuildContext context) {
    return CContainer(
      alignment: Alignment.center,
      color: Colors.white,
      child: CText("订单"),
    );
  }

}