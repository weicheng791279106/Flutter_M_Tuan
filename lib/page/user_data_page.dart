import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/manager/acm.dart';
import 'package:m_tuan_flutter/model/resp/login_resp.dart';
import 'package:m_tuan_flutter/model/resp/update_avatar_resp.dart';
import 'package:m_tuan_flutter/util/http.dart';
import 'package:m_tuan_flutter/util/pick_image_util.dart';
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

  User user;

  @override
  void initState() {
    super.initState();
    AcM.getUser().then((user) => setState(() => this.user = user));
  }

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
            CommentBar("头像",
              contentWidget: CCircleAvatar(user?.avatarUrl),
              onTap: ()=> PickImageUtil.pickImage(context, (File image) => uploadAvatar(image)),
            ),
            Divider(height: 0.1,),
            CommentBar("昵称",content: user == null ? "":user.name,),
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

  /**上传头像*/
  Future uploadAvatar(File file) async {
    UpdateAvatarResp response = UpdateAvatarResp(await Http.post(
        context,
        "user/updateAvatar",
        FormData.from({
          "avatarImage": UploadFileInfo(file, "avatar.jpg"),
        })));
    if (response.code != Http.SUCCESS) return;
    Fluttertoast.showToast(msg: "更新成功");
    user.avatarUrl = response.avatarImageUrl;
    AcM.saveUser(user, await AcM.token());
    setState((){});
  }

}