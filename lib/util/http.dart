import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_tuan_flutter/conts/sp_key.dart';
import 'package:m_tuan_flutter/manager/acm.dart';
import 'package:m_tuan_flutter/model/resp/base_resp.dart';
import 'package:m_tuan_flutter/page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**Http封装*/
class Http{

  static const SUCCESS = 10000;
  static const FAILED = -10000;
  static const TOKEN_ERROR = -10001;

  static const TIMEOUT_MILS = 5000;
  static const BASE_URL = "http://10.0.2.244:8080/";

  static Dio dio;
  static final Options dioOptions = Options(connectTimeout: TIMEOUT_MILS,receiveTimeout: TIMEOUT_MILS);

  static Future post(BuildContext context,String url,FormData data,
      {Function(String data) onSuccess,Function(String msg) onError,Function() onAfter,Function() onBefore}) async{
    if(onBefore != null) onBefore();
    try{
      if(data == null) data = FormData();
      data.add("token", await AcM.token());
      print("HTTP POST：${BASE_URL}${url} ${data}" );
      Response response = await getDio().post(url,data:data,options: dioOptions);
      print("RESPONSE：${BASE_URL}${url} ${response}");
      BaseResp baseResp = BaseResp(response.data);
      if(baseResp.code != SUCCESS) onError(baseResp.msg);
      if(baseResp.code == TOKEN_ERROR) AcM.logout(context); /*自动退出登录判断*/
      if(onSuccess != null) onSuccess(response.toString());
    }on Error catch(e){
      print("HTTP ERROR：$e");
      if(onError != null) onError("请求错误");
    }
    if(onAfter != null) onAfter();
  }

  static Dio getDio(){
    if(dio != null) return dio;
    dio = new Dio();
    dio.options.baseUrl = BASE_URL;
    return dio;
  }

}