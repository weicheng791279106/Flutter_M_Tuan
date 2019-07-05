import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';

class LoadingWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return CContainer(
      expand: true,
      height: double.maxFinite,
      color: Colors.white,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

}