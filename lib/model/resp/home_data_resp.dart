import 'dart:convert' show json;

class HomeDataResp {

  int code;
  String msg;
  List<Func> mainFuncList;
  List<Func> subFuncList;

  HomeDataResp.fromParams({this.code, this.msg, this.mainFuncList, this.subFuncList});

  factory HomeDataResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new HomeDataResp.fromJson(json.decode(jsonStr)) : new HomeDataResp.fromJson(jsonStr);

  HomeDataResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    mainFuncList = jsonRes['mainFuncList'] == null ? null : [];

    for (var mainFuncListItem in mainFuncList == null ? [] : jsonRes['mainFuncList']){
      mainFuncList.add(mainFuncListItem == null ? null : new Func.fromJson(mainFuncListItem));
    }

    subFuncList = jsonRes['subFuncList'] == null ? null : [];

    for (var subFuncListItem in subFuncList == null ? [] : jsonRes['subFuncList']){
      subFuncList.add(subFuncListItem == null ? null : new Func.fromJson(subFuncListItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"mainFuncList": $mainFuncList,"subFuncList": $subFuncList}';
  }
}

class Func {

  String tag;
  int id;
  int status;
  int type;
  String imageUrl;
  String name;

  Func.fromParams({this.tag, this.id, this.status, this.type, this.imageUrl, this.name});

  Func.fromJson(jsonRes) {
    tag = jsonRes['tag'];
    id = jsonRes['id'];
    status = jsonRes['status'];
    type = jsonRes['type'];
    imageUrl = jsonRes['imageUrl'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"tag": ${tag != null?'${json.encode(tag)}':'null'},"id": $id,"status": $status,"type": $type,"imageUrl": ${imageUrl != null?'${json.encode(imageUrl)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}



