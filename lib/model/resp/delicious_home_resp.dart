import 'dart:convert' show json;

import 'package:m_tuan_flutter/model/resp/home_data_resp.dart';

class DeliciousHomeResp {

  int code;
  String msg;
  List<HomeBanner> bannerList;
  List<Discount> discountList;
  List<Func> mainFuncList;
  List<Func> subFuncList;

  DeliciousHomeResp.fromParams({this.code, this.msg, this.bannerList, this.discountList, this.mainFuncList, this.subFuncList});

  factory DeliciousHomeResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new DeliciousHomeResp.fromJson(json.decode(jsonStr)) : new DeliciousHomeResp.fromJson(jsonStr);

  DeliciousHomeResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    bannerList = jsonRes['bannerList'] == null ? null : [];

    for (var bannerListItem in bannerList == null ? [] : jsonRes['bannerList']){
      bannerList.add(bannerListItem == null ? null : new HomeBanner.fromJson(bannerListItem));
    }

    discountList = jsonRes['discountList'] == null ? null : [];

    for (var discountListItem in discountList == null ? [] : jsonRes['discountList']){
      discountList.add(discountListItem == null ? null : new Discount.fromJson(discountListItem));
    }

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
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"bannerList": $bannerList,"discountList": $discountList,"mainFuncList": $mainFuncList,"subFuncList": $subFuncList}';
  }
}



