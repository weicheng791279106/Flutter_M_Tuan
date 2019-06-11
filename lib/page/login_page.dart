import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/dialog/loading_dialog.dart';
import 'package:m_tuan_flutter/manager/acm.dart';
import 'package:m_tuan_flutter/model/resp/login_resp.dart';
import 'package:m_tuan_flutter/page/main_index_page.dart';
import 'package:m_tuan_flutter/util/http.dart';
import 'package:m_tuan_flutter/util/navigator_util.dart';
import 'package:m_tuan_flutter/util/string_util.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:m_tuan_flutter/widget/c_textfield.dart';

class LoginPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }

}

class LoginPageState extends State<LoginPage>{

  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPhoneOk = !StringUtils.isEmpty(controller.text) && controller.text.length == 11;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.close,color: CColors.primary,size: 30,),
        actions: <Widget>[
          Container(
            height: double.infinity,
            alignment: Alignment.center,
            child: CText("帮助",textColor: CColors.primary,textSize: 17,margin: EdgeInsets.only(right: 10),),
          )
        ],
      ),
      body: CContainer(
        color: Colors.white,
        padding: EdgeInsets.only(left: 40,right: 40),
        direction: Direction.column,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CText("欢迎登录美团",textSize: 30,textColor: Colors.black,margin: EdgeInsets.only(top: 40),),
          CContainer(
            direction: Direction.row,
            margin: EdgeInsets.only(top: 50),
            children: <Widget>[
              CText("+86",textSize: 14,textColor: Colors.grey,icon: Icons.chevron_right,iconSize: 20,),
              CTextField(
                maxLength: 11,
                margin: EdgeInsets.only(left: 10),
                hint: "请输入手机号",
                textSize: 18,
                textColor: Colors.black,
                keyboardType: TextInputType.phone,
                controller: controller,
                onChanged: (text) => setState(() {}),
              ),
              StringUtils.isEmpty(controller.text) ? SizedBox():
              GestureDetector(
                child: Icon(Icons.close,color: Colors.grey,),
                onTap: () => setState(() => controller.clear()) ,
              ),
            ],
          ),
          Divider(height: 10,color: Colors.grey,),
          CText("未注册的手机号验证后自动创建美团账户",textColor: Colors.grey,textSize: 13,margin: EdgeInsets.only(top: 5),),
          CContainer(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.only(top: 14,bottom: 14),
            borderRadius: 25,
            alignment: Alignment.center,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(isPhoneOk ? 255:120, 0, 214, 200),
                Color.fromARGB(isPhoneOk ? 255:120, 2, 190, 178),
              ],
            ),
            boxShadow: isPhoneOk ? BoxShadow(offset: Offset(0,16),color:Colors.grey,blurRadius: 5,spreadRadius: -15):null,
            onTap: () => requestLogin(context, controller.text),
            child: CText("获取短信验证码",textSize: 17,textColor: Colors.white,),
          ),
          Expanded(child: SizedBox(),),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CImage(asset: "images/ic_login_wchat.png",scale: 2.0,),
                  CImage(asset: "images/ic_login_qq.png",scale: 2.0,),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 25,bottom: 15),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.grey,fontSize: 13),
                      children: [
                        TextSpan(text: "登录代表你已同意"),
                        TextSpan(text: "美团用户协议",style: TextStyle(color: CColors.primary)),
                        TextSpan(text: "、"),
                        TextSpan(text: "隐私政策",style: TextStyle(color: CColors.primary)),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /**请求登录*/
  Future requestLogin(BuildContext context,String phone) async {
    Http.post(context, "user/login",
      FormData.from({
        "phone":phone,
        "pwd":"123456",
      }),
      onSuccess: (data) async {
        LoginResp response = LoginResp(data);
        await AcM.saveUser(response.user, response.token);
        NavigatorUtil.pushAndClose(context, MainIndexPage());
      },
      onError: (msg) => Fluttertoast.showToast(msg: msg),
      onBefore: () => LoadingDialog.show(context),
      onAfter: () => Navigator.pop(context),
    );
  }

}