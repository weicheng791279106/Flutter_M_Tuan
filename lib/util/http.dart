import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_tuan_flutter/conts/sp_key.dart';
import 'package:m_tuan_flutter/model/resp/base_resp.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Http封装
class Http{

  static const SUCCESS = 10000;
  static const FAILED = -10000;
  static const TOKEN_ERROR = -10001;

  static post(BuildContext context,String url,FormData data) async {
    try{
      print("HTTP POST：${url} ${data}" );
      Response response = await Dio().post(url,data:data);
      print("RESPONSE：${url} ${response}");
      BaseResp baseResp = new BaseResp(response.data);
      if(baseResp.code != SUCCESS) Fluttertoast.showToast(msg: baseResp.msg);
      //if(baseResp.code == TOKEN_ERROR) _logout(context); //TODO：自动退出登录判断
      return response.data;
    }catch(e){
      Fluttertoast.showToast(msg: "网络错误");
      return BaseResp.fromParams(code:FAILED,msg:"网络错误").toString();
    }
  }

  ///退出登录
  static void _logout(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SpKey.NAME, null);
    prefs.setString(SpKey.AVATAR_URL, null);
    prefs.setString(SpKey.TOKEN, null);
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context){
              //return new LoginPage();
            }
        ), (route) => route == null
    );
  }

}