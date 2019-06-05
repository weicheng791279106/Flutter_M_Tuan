import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/sp_key.dart';
import 'package:m_tuan_flutter/event/event_bus.dart';
import 'package:m_tuan_flutter/model/resp/login_resp.dart';
import 'package:m_tuan_flutter/page/login_page.dart';
import 'package:m_tuan_flutter/util/string_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * 用户管理器
 * */
class AcM{

  /**读取当前用户*/
  static Future<User> getUser() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(StringUtils.isEmpty(sp.getString(SpKey.TOKEN))) return null;
    return User.fromParams(
      id: sp.getInt(SpKey.USER_ID),
      name: sp.getString(SpKey.USER_NAME),
      phone: sp.getString(SpKey.USER_PHONE),
      avatarUrl: sp.getString(SpKey.USER_AVATAR_URL),
    );
  }

  /**获取Token*/
  static Future<String> token() async{
    SharedPreferences sp = await SharedPreferences.getInstance();

    print("aaaa" + sp.getString(SpKey.TOKEN));

    return sp.getString(SpKey.TOKEN);
  }

  /**保存当前用户*/
  static Future saveUser(User user,String token) async{
    if(user == null || StringUtils.isEmpty(token)) return null;
    await SharedPreferences.getInstance()
      ..setString(SpKey.TOKEN, token)
      ..setInt(SpKey.USER_ID, user.id)
      ..setString(SpKey.USER_NAME, user.name)
      ..setString(SpKey.USER_PHONE, user.phone)
      ..setString(SpKey.USER_AVATAR_URL, user.avatarUrl);
    eventBus.fire(new LoginEvent(user));
  }

  /**清空当前用户*/
  static Future cleanUser() async{
    await SharedPreferences.getInstance()
      ..setString(SpKey.TOKEN, "")
      ..setInt(SpKey.USER_ID, 0)
      ..setString(SpKey.USER_NAME, "")
      ..setString(SpKey.USER_PHONE, "")
      ..setString(SpKey.USER_AVATAR_URL, "");
    eventBus.fire(new LogoutEvent());
  }

  /**退出登录*/
  static void logout(BuildContext context) async{
    await AcM.cleanUser();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()
        ), (route) => route == null
    );
  }

}