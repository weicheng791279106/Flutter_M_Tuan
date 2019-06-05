
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';

class DialogUtil{

  static void alertDialog(
      BuildContext context,
      String title,
      String positiveBt,VoidCallback positiveCallback,
      String negativeBt,VoidCallback negativeCallback
      ){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: CText(title,textSize: 17,),
            actions: <Widget>[
              FlatButton(
                child: CText(negativeBt,textSize: 17,textColor: Colors.grey,),
                onPressed: () {
                  Navigator.pop(context);
                  negativeCallback();
                },
              ),
              FlatButton(
                child: CText(positiveBt,textSize: 17,textColor: Colors.blue,),
                onPressed: (){
                  positiveCallback();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }


}