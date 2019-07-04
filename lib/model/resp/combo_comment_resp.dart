import 'dart:convert' show json;

import 'package:m_tuan_flutter/model/resp/login_resp.dart';

class ComboCommentResp {

  int code;
  String msg;
  List<Comment> commentList;

  ComboCommentResp.fromParams({this.code, this.msg, this.commentList});

  factory ComboCommentResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ComboCommentResp.fromJson(json.decode(jsonStr)) : new ComboCommentResp.fromJson(jsonStr);

  ComboCommentResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    commentList = jsonRes['commentList'] == null ? null : [];

    for (var commentListItem in commentList == null ? [] : jsonRes['commentList']){
      commentList.add(commentListItem == null ? null : new Comment.fromJson(commentListItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"commentList": $commentList}';
  }
}

class Comment {

  int createDate;
  int id;
  double star;
  bool quality;
  String content;
  List<String> imageList;
  User createUser;

  Comment.fromParams({this.createDate, this.id, this.star, this.quality, this.content, this.imageList, this.createUser});

  Comment.fromJson(jsonRes) {
    createDate = jsonRes['createDate'];
    id = jsonRes['id'];
    star = jsonRes['star'];
    quality = jsonRes['quality'];
    content = jsonRes['content'];
    imageList = jsonRes['imageList'] == null ? null : [];

    for (var imageListItem in imageList == null ? [] : jsonRes['imageList']){
      imageList.add(imageListItem);
    }

    createUser = jsonRes['createUser'] == null ? null : new User.fromJson(jsonRes['createUser']);
  }

  @override
  String toString() {
    return '{"createDate": $createDate,"id": $id,"star": $star,"quality": $quality,"content": ${content != null?'${json.encode(content)}':'null'},"imageList": $imageList,"createUser": $createUser}';
  }
}


