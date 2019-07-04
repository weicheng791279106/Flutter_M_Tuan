import 'dart:convert' show json;

class DeliciousListResp {

  int code;
  String msg;
  List<Delicious> deliciousList;

  DeliciousListResp.fromParams({this.code, this.msg, this.deliciousList});

  factory DeliciousListResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new DeliciousListResp.fromJson(json.decode(jsonStr)) : new DeliciousListResp.fromJson(jsonStr);

  DeliciousListResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    deliciousList = jsonRes['deliciousList'] == null ? null : [];

    for (var deliciousListItem in deliciousList == null ? [] : jsonRes['deliciousList']){
      deliciousList.add(deliciousListItem == null ? null : new Delicious.fromJson(deliciousListItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"deliciousList": $deliciousList}';
  }
}

class Delicious {

  int hotTagSize;
  int id;
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

  Delicious.fromParams({this.hotTagSize, this.id, this.star, this.deliveryable, this.open, this.orderable, this.bossSay, this.classify, this.couponDiscount, this.distance, this.groupDiscount, this.imageUrl, this.local, this.payDiscount, this.populatiry, this.price, this.tagList, this.title, this.imageUrlList, this.tagStrList});

  Delicious.fromJson(jsonRes) {
    hotTagSize = jsonRes['hotTagSize'];
    id = jsonRes['id'];
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
    return '{"hotTagSize": $hotTagSize,"id": $id,"star": $star,"deliveryable": $deliveryable,"open": $open,"orderable": $orderable,"bossSay": ${bossSay != null?'${json.encode(bossSay)}':'null'},"classify": ${classify != null?'${json.encode(classify)}':'null'},"couponDiscount": ${couponDiscount != null?'${json.encode(couponDiscount)}':'null'},"distance": ${distance != null?'${json.encode(distance)}':'null'},"groupDiscount": ${groupDiscount != null?'${json.encode(groupDiscount)}':'null'},"imageUrl": ${imageUrl != null?'${json.encode(imageUrl)}':'null'},"local": ${local != null?'${json.encode(local)}':'null'},"payDiscount": ${payDiscount != null?'${json.encode(payDiscount)}':'null'},"populatiry": ${populatiry != null?'${json.encode(populatiry)}':'null'},"price": ${price != null?'${json.encode(price)}':'null'},"tagList": ${tagList != null?'${json.encode(tagList)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"imageUrlList": $imageUrlList,"tagStrList": $tagStrList}';
  }
}

