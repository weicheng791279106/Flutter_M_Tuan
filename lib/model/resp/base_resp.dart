import 'dart:convert' show json;

class BaseResp {

  int code;
  String msg;

  BaseResp.fromParams({this.code, this.msg});

  factory BaseResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BaseResp.fromJson(json.decode(jsonStr)) : new BaseResp.fromJson(jsonStr);

  BaseResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'}}';
  }
}

