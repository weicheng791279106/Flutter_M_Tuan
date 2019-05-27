import 'dart:convert' show json;

class LoginResp {

  int code;
  String msg;
  String token;
  User user;

  LoginResp.fromParams({this.code, this.msg, this.token, this.user});

  factory LoginResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new LoginResp.fromJson(json.decode(jsonStr)) : new LoginResp.fromJson(jsonStr);

  LoginResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    token = jsonRes['token'];
    user = jsonRes['user'] == null ? null : new User.fromJson(jsonRes['user']);
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"token": ${token != null?'${json.encode(token)}':'null'},"user": $user}';
  }
}

class User {

  int createDate;
  int id;
  String avatarUrl;
  String name;
  String phone;
  String pwd;

  User.fromParams({this.createDate, this.id, this.avatarUrl, this.name, this.phone, this.pwd});

  User.fromJson(jsonRes) {
    createDate = jsonRes['createDate'];
    id = jsonRes['id'];
    avatarUrl = jsonRes['avatarUrl'];
    name = jsonRes['name'];
    phone = jsonRes['phone'];
    pwd = jsonRes['pwd'];
  }

  @override
  String toString() {
    return '{"createDate": $createDate,"id": $id,"avatarUrl": ${avatarUrl != null?'${json.encode(avatarUrl)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"phone": ${phone != null?'${json.encode(phone)}':'null'},"pwd": ${pwd != null?'${json.encode(pwd)}':'null'}}';
  }
}

