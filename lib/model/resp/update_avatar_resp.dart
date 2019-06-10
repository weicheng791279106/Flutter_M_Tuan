import 'dart:convert' show json;

class UpdateAvatarResp {

  int code;
  String avatarImageUrl;
  String msg;

  UpdateAvatarResp.fromParams({this.code, this.avatarImageUrl, this.msg});

  factory UpdateAvatarResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new UpdateAvatarResp.fromJson(json.decode(jsonStr)) : new UpdateAvatarResp.fromJson(jsonStr);

  UpdateAvatarResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    avatarImageUrl = jsonRes['avatarImageUrl'];
    msg = jsonRes['msg'];
  }

  @override
  String toString() {
    return '{"code": $code,"avatarImageUrl": ${avatarImageUrl != null?'${json.encode(avatarImageUrl)}':'null'},"msg": ${msg != null?'${json.encode(msg)}':'null'}}';
  }
}

