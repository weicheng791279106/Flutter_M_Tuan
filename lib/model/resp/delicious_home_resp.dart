import 'dart:convert' show json;

import 'package:m_tuan_flutter/model/resp/home_data_resp.dart';

class DeliciousHomeResp {

  int code;
  String msg;
  List<Banner> bannerList;
  List<Delicious> deliciousList;
  List<Discount> discountList;
  List<Func> mainFuncList;
  List<Func> subFuncList;

  DeliciousHomeResp.fromParams({this.code, this.msg, this.bannerList, this.deliciousList, this.discountList, this.mainFuncList, this.subFuncList});

  factory DeliciousHomeResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new DeliciousHomeResp.fromJson(json.decode(jsonStr)) : new DeliciousHomeResp.fromJson(jsonStr);

  DeliciousHomeResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    bannerList = jsonRes['bannerList'] == null ? null : [];

    for (var bannerListItem in bannerList == null ? [] : jsonRes['bannerList']){
      bannerList.add(bannerListItem == null ? null : new Banner.fromJson(bannerListItem));
    }

    deliciousList = jsonRes['deliciousList'] == null ? null : [];

    for (var deliciousListItem in deliciousList == null ? [] : jsonRes['deliciousList']){
      deliciousList.add(deliciousListItem == null ? null : new Delicious.fromJson(deliciousListItem));
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
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"bannerList": $bannerList,"deliciousList": $deliciousList,"discountList": $discountList,"mainFuncList": $mainFuncList,"subFuncList": $subFuncList}';
  }
}

class Delicious {

  int hotTagSize;
  double star;
  bool deliveryable;
  bool open;
  bool orderable;
  String bossSay;
  String classify;
  String couponDiscount;
  String distance;
  String groupDiscount;
  String imageUrl;
  String local;
  String payDiscount;
  String populatiry;
  String price;
  String tagList;
  String title;
  List<String> imageUrlList;
  List<String> tagStrList;

  Delicious.fromParams({this.hotTagSize, this.star, this.deliveryable, this.open, this.orderable, this.bossSay, this.classify, this.couponDiscount, this.distance, this.groupDiscount, this.imageUrl, this.local, this.payDiscount, this.populatiry, this.price, this.tagList, this.title, this.imageUrlList, this.tagStrList});

  Delicious.fromJson(jsonRes) {
    hotTagSize = jsonRes['hotTagSize'];
    star = jsonRes['star'];
    deliveryable = jsonRes['deliveryable'];
    open = jsonRes['open'];
    orderable = jsonRes['orderable'];
    bossSay = jsonRes['bossSay'];
    classify = jsonRes['classify'];
    couponDiscount = jsonRes['couponDiscount'];
    distance = jsonRes['distance'];
    groupDiscount = jsonRes['groupDiscount'];
    imageUrl = jsonRes['imageUrl'];
    local = jsonRes['local'];
    payDiscount = jsonRes['payDiscount'];
    populatiry = jsonRes['populatiry'];
    price = jsonRes['price'];
    tagList = jsonRes['tagList'];
    title = jsonRes['title'];
    imageUrlList = jsonRes['imageUrlList'] == null ? null : [];

    for (var imageUrlListItem in imageUrlList == null ? [] : jsonRes['imageUrlList']){
      imageUrlList.add(imageUrlListItem);
    }

    tagStrList = jsonRes['tagStrList'] == null ? null : [];

    for (var tagStrListItem in tagStrList == null ? [] : jsonRes['tagStrList']){
      tagStrList.add(tagStrListItem);
    }
  }

  @override
  String toString() {
    return '{"hotTagSize": $hotTagSize,"star": $star,"deliveryable": $deliveryable,"open": $open,"orderable": $orderable,"bossSay": ${bossSay != null?'${json.encode(bossSay)}':'null'},"classify": ${classify != null?'${json.encode(classify)}':'null'},"couponDiscount": ${couponDiscount != null?'${json.encode(couponDiscount)}':'null'},"distance": ${distance != null?'${json.encode(distance)}':'null'},"groupDiscount": ${groupDiscount != null?'${json.encode(groupDiscount)}':'null'},"imageUrl": ${imageUrl != null?'${json.encode(imageUrl)}':'null'},"local": ${local != null?'${json.encode(local)}':'null'},"payDiscount": ${payDiscount != null?'${json.encode(payDiscount)}':'null'},"populatiry": ${populatiry != null?'${json.encode(populatiry)}':'null'},"price": ${price != null?'${json.encode(price)}':'null'},"tagList": ${tagList != null?'${json.encode(tagList)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"imageUrlList": $imageUrlList,"tagStrList": $tagStrList}';
  }
}

class Banner {

  int id;
  int type;
  String imageUrl;
  String title;

  Banner.fromParams({this.id, this.type, this.imageUrl, this.title});

  Banner.fromJson(jsonRes) {
    id = jsonRes['id'];
    type = jsonRes['type'];
    imageUrl = jsonRes['imageUrl'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"id": $id,"type": $type,"imageUrl": ${imageUrl != null?'${json.encode(imageUrl)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}

