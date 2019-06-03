import 'dart:convert' show json;

import 'package:m_tuan_flutter/model/resp/login_resp.dart';

class DiscoverListResp {

  int code;
  String msg;
  List<Discover> discoverList;

  DiscoverListResp.fromParams({this.code, this.msg, this.discoverList});

  factory DiscoverListResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new DiscoverListResp.fromJson(json.decode(jsonStr)) : new DiscoverListResp.fromJson(jsonStr);

  DiscoverListResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    discoverList = jsonRes['discoverList'] == null ? null : [];

    for (var discoverListItem in discoverList == null ? [] : jsonRes['discoverList']){
      discoverList.add(discoverListItem == null ? null : new Discover.fromJson(discoverListItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"discoverList": $discoverList}';
  }
}

class Discover {

  int id;
  int thumbsUpCount;
  String imageUrl;
  String title;
  User createUser;

  Discover.fromParams({this.id, this.thumbsUpCount, this.imageUrl, this.title, this.createUser});

  Discover.fromJson(jsonRes) {
    id = jsonRes['id'];
    thumbsUpCount = jsonRes['thumbsUpCount'];
    imageUrl = jsonRes['imageUrl'];
    title = jsonRes['title'];
    createUser = jsonRes['createUser'] == null ? null : new User.fromJson(jsonRes['createUser']);
  }

  @override
  String toString() {
    return '{"id": $id,"thumbsUpCount": $thumbsUpCount,"imageUrl": ${imageUrl != null?'${json.encode(imageUrl)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"createUser": $createUser}';
  }
}

