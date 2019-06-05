import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';

/**通用的设置栏*/
class CommentBar extends StatelessWidget{

  String title;
  String content;
  Widget contentWidget;
  GestureTapCallback onTap;

  CommentBar(this.title, {this.content,this.contentWidget,this.onTap});

  @override
  Widget build(BuildContext context) {
    return CContainer(
      onTap: onTap,
      color: Colors.white,
      padding: EdgeInsets.only(left: 15,top: 12,bottom: 12,right: 7),
      direction: Direction.row,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CText(title,bold:true,textSize: 16,textColor: CColors.textTitle,),
        Row(
          children: <Widget>[
            contentWidget ?? CText(content,textSize:15,textColor: Colors.grey,),
            Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
          ],
        ),
      ],
    );
  }

}