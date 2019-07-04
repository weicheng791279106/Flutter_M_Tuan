import 'dart:convert' show json;

import 'package:m_tuan_flutter/model/resp/delicious_list_resp.dart';
import 'package:scoped_model/scoped_model.dart';

class ComboInfoResp {

  int code;
  String msg;
  Combo combo;

  ComboInfoResp.fromParams({this.code, this.msg, this.combo});

  factory ComboInfoResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ComboInfoResp.fromJson(json.decode(jsonStr)) : new ComboInfoResp.fromJson(jsonStr);

  ComboInfoResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    combo = jsonRes['combo'] == null ? null : new Combo.fromJson(jsonRes['combo']);
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"combo": $combo}';
  }
}

class Combo {

  int id;
  double originalPrice;
  double price;
  String comboName;
  String comboSimpleName;
  String discount;
  String imageUrl;
  String tips;
  List<FoodModel> foodList;
  Delicious delicious;

  Combo.fromParams({this.id, this.originalPrice, this.price, this.comboName, this.comboSimpleName, this.discount, this.imageUrl, this.tips, this.foodList, this.delicious});

  Combo.fromJson(jsonRes) {
    id = jsonRes['id'];
    originalPrice = jsonRes['originalPrice'];
    price = jsonRes['price'];
    comboName = jsonRes['comboName'];
    comboSimpleName = jsonRes['comboSimpleName'];
    discount = jsonRes['discount'];
    imageUrl = jsonRes['imageUrl'];
    tips = jsonRes['tips'];
    foodList = jsonRes['foodList'] == null ? null : [];

    for (var foodListItem in foodList == null ? [] : jsonRes['foodList']){
      foodList.add(foodListItem == null ? null : new FoodModel.fromJson(foodListItem));
    }

    delicious = jsonRes['delicious'] == null ? null : new Delicious.fromJson(jsonRes['delicious']);
  }

  @override
  String toString() {
    return '{"id": $id,"originalPrice": $originalPrice,"price": $price,"comboName": ${comboName != null?'${json.encode(comboName)}':'null'},"comboSimpleName": ${comboSimpleName != null?'${json.encode(comboSimpleName)}':'null'},"discount": ${discount != null?'${json.encode(discount)}':'null'},"imageUrl": ${imageUrl != null?'${json.encode(imageUrl)}':'null'},"tips": ${tips != null?'${json.encode(tips)}':'null'},"foodList": $foodList,"delicious": $delicious}';
  }
}

class FoodModel {

  int count;
  double price;
  bool recommend;
  String name;

  FoodModel.fromParams({this.count, this.price, this.recommend, this.name});

  FoodModel.fromJson(jsonRes) {
    count = jsonRes['count'];
    price = jsonRes['price'];
    recommend = jsonRes['recommend'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"count": $count,"price": $price,"recommend": $recommend,"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}

