import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/manager/acm.dart';
import 'package:m_tuan_flutter/page/user_data_page.dart';
import 'package:m_tuan_flutter/util/dialog_util.dart';
import 'package:m_tuan_flutter/util/navigator_util.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:m_tuan_flutter/widget/commen_bar.dart';

class SettingPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }

}

class SettingPageState extends State<SettingPage>{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CColors.bgDefault,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: () => Navigator.pop(context)),
          title: CText("设置",textSize: 18,),
        ),
        body: SingleChildScrollView(
          child: CContainer(
            direction: Direction.column,
            children: <Widget>[
              SizedBox(height: 10,),
              CommentBar("个人信息",onTap: () => NavigatorUtil.pushWithAnimation(context, UserDataPage()),),
              Divider(height: 0.1,),
              CommentBar("换绑手机",content: "13049837818",),
              Divider(height: 0.1,),
              CommentBar("社交账号绑定",content: "绑定/解绑",),
              Divider(height: 0.1,),
              CommentBar("登录密码",content: "修改",),
              Divider(height: 0.1,),
              CommentBar("支付设置"),
              SizedBox(height: 10,),
              CommentBar("安全中心"),
              Divider(height: 0.1,),
              CommentBar("通用"),
              SizedBox(height: 10,),
              CommentBar("关于美团"),
              CContainer(
                color: Colors.white,
                margin: EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 20),
                padding: EdgeInsets.only(top: 13,bottom: 13),
                alignment: Alignment.center,
                child: CText("退出账户",textSize: 18,textColor: Colors.black,bold: true,),
                borderRadius: 2,
                boxShadow: BoxShadow(color: Colors.grey[300],offset: Offset(0, 3),blurRadius: 1,spreadRadius: 1),
                //onTap: () => AcM.logout(context)
                onTap: () =>
                    DialogUtil.alertDialog(context, "确定退出登录吗？", "确定", ()=> AcM.logout(context),"取消", null)
              ),
            ],
          ),
        ),
      ),
    );
  }

}

