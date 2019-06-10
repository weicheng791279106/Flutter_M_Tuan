import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';

class LoadingDialog extends StatefulWidget{

  /**显示loading*/
  static void show(BuildContext context){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => LoadingDialog()
    );
  }

  @override
  State<StatefulWidget> createState() {
    return LoadingDialogState();
  }

}

class LoadingDialogState extends State<LoadingDialog>{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CContainer(
        borderRadius: 5,
        color: Colors.white,
        direction: Direction.column,
        mainAxisSize: MainAxisSize.min,
        padding: EdgeInsets.all(15),
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      ),
    );
  }

}