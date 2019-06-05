import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/widget/c_circle_avatar.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:m_tuan_flutter/widget/commen_bar.dart';

class UserDataPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return UserDataPageState();
  }

}

class UserDataPageState extends State<UserDataPage>{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CColors.bgDefault,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: () => Navigator.pop(context)),
          title: CText("个人信息",textSize: 18,),
        ),
        body: CContainer(
          direction: Direction.column,
          children: <Widget>[
            SizedBox(height: 10,),
            CommentBar("头像",contentWidget: CCircleAvatar(""),),
            Divider(height: 0.1,),
            CommentBar("昵称",content: "你丫闭嘴216",),
            Divider(height: 0.1,),
            CommentBar("生日",content: "未设置",),
            Divider(height: 0.1,),
            CommentBar("收货地址",content: "修改/添加",),
            Divider(height: 0.1,),
          ],
        ),
      ),
    );
  }

}