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

  static const TIMEOUT_MILS = 5000;
  static const BASE_URL = "http://10.0.4.145:8080/";

  static Dio dio;

  static Future<String> post(BuildContext context,String url,FormData data) async {
    try{
      print("HTTP POST：${BASE_URL}${url} ${data}" );
      Response response = await getDio().post(url,data:data);
      print("RESPONSE：${BASE_URL}${url} ${response}");
      BaseResp baseResp = new BaseResp(response.data);
      if(baseResp.code != SUCCESS) Fluttertoast.showToast(msg: baseResp.msg);
      //if(baseResp.code == TOKEN_ERROR) _logout(context); //TODO：自动退出登录判断
      return response.toString();
    }catch(e){
      Fluttertoast.showToast(msg: "网络错误");
      return BaseResp.fromParams(code:FAILED,msg:"网络错误").toString();
    }
  }

  static Dio getDio(){
    if(dio != null) return dio;
    dio = new Dio();
    dio.options.baseUrl = BASE_URL;
    dio.options.connectTimeout = TIMEOUT_MILS;
    dio.options.receiveTimeout = TIMEOUT_MILS;
    return dio;
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