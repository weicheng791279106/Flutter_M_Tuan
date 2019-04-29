import 'dart:convert' show json;

class HomeDataResp {

  int code;
  String msg;
  List<HomeBanner> bannerList;
  List<DiscountItem> discountList;
  List<Hotel> hotelList;
  List<Func> mainFuncList;
  List<Movie> movieList;
  List<Func> subFuncList;

  HomeDataResp.fromParams({this.code, this.msg, this.bannerList, this.discountList, this.hotelList, this.mainFuncList, this.movieList, this.subFuncList});

  factory HomeDataResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new HomeDataResp.fromJson(json.decode(jsonStr)) : new HomeDataResp.fromJson(jsonStr);

  HomeDataResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    bannerList = jsonRes['bannerList'] == null ? null : [];

    for (var bannerListItem in bannerList == null ? [] : jsonRes['bannerList']){
      bannerList.add(bannerListItem == null ? null : new HomeBanner.fromJson(bannerListItem));
    }

    discountList = jsonRes['discountList'] == null ? null : [];

    for (var discountListItem in discountList == null ? [] : jsonRes['discountList']){
      discountList.add(discountListItem == null ? null : new DiscountItem.fromJson(discountListItem));
    }

    hotelList = jsonRes['hotelList'] == null ? null : [];

    for (var hotelListItem in hotelList == null ? [] : jsonRes['hotelList']){
      hotelList.add(hotelListItem == null ? null : new Hotel.fromJson(hotelListItem));
    }

    mainFuncList = jsonRes['mainFuncList'] == null ? null : [];

    for (var mainFuncListItem in mainFuncList == null ? [] : jsonRes['mainFuncList']){
      mainFuncList.add(mainFuncListItem == null ? null : new Func.fromJson(mainFuncListItem));
    }

    movieList = jsonRes['movieList'] == null ? null : [];

    for (var movieListItem in movieList == null ? [] : jsonRes['movieList']){
      movieList.add(movieListItem == null ? null : new Movie.fromJson(movieListItem));
    }

    subFuncList = jsonRes['subFuncList'] == null ? null : [];

    for (var subFuncListItem in subFuncList == null ? [] : jsonRes['subFuncList']){
      subFuncList.add(subFuncListItem == null ? null : new Func.fromJson(subFuncListItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"bannerList": $bannerList,"discountList": $discountList,"hotelList": $hotelList,"mainFuncList": $mainFuncList,"movieList": $movieList,"subFuncList": $subFuncList}';
  }
}

class Func {

  Object tag;
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
    return '{"tag": $tag,"id": $id,"status": $status,"type": $type,"imageUrl": ${imageUrl != null?'${json.encode(imageUrl)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}

class Movie {

  int id;
  String imageUrl;
  String score;
  String title;

  Movie.fromParams({this.id, this.imageUrl, this.score, this.title});

  Movie.fromJson(jsonRes) {
    id = jsonRes['id'];
    imageUrl = jsonRes['imageUrl'];
    score = jsonRes['score'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"id": $id,"imageUrl": ${imageUrl != null?'${json.encode(imageUrl)}':'null'},"score": ${score != null?'${json.encode(score)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}

class Hotel {

  int id;
  String imageUrl;
  String name;
  String price;
  String tag;

  Hotel.fromParams({this.id, this.imageUrl, this.name, this.price, this.tag});

  Hotel.fromJson(jsonRes) {
    id = jsonRes['id'];
    imageUrl = jsonRes['imageUrl'];
    name = jsonRes['name'];
    price = jsonRes['price'];
    tag = jsonRes['tag'];
  }

  @override
  String toString() {
    return '{"id": $id,"imageUrl": ${imageUrl != null?'${json.encode(imageUrl)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"price": ${price != null?'${json.encode(price)}':'null'},"tag": ${tag != null?'${json.encode(tag)}':'null'}}';
  }
}

class DiscountItem {

  Object title;
  int id;
  int type;
  List<Discount> discountList;

  DiscountItem.fromParams({this.title, this.id, this.type, this.discountList});

  DiscountItem.fromJson(jsonRes) {
    title = jsonRes['title'];
    id = jsonRes['id'];
    type = jsonRes['type'];
    discountList = jsonRes['discountList'] == null ? null : [];

    for (var discountListItem in discountList == null ? [] : jsonRes['discountList']){
      discountList.add(discountListItem == null ? null : new Discount.fromJson(discountListItem));
    }
  }

  @override
  String toString() {
    return '{"title": $title,"id": $id,"type": $type,"discountList": $discountList}';
  }
}

class Discount {

  int id;
  String desc;
  String discount;
  String distance;
  String originalPrice;
  String price;
  String tag;
  String title;
  List<String> imageList;

  Discount.fromParams({this.id, this.desc, this.discount, this.distance, this.originalPrice, this.price, this.tag, this.title, this.imageList});

  Discount.fromJson(jsonRes) {
    id = jsonRes['id'];
    desc = jsonRes['desc'];
    discount = jsonRes['discount'];
    distance = jsonRes['distance'];
    originalPrice = jsonRes['originalPrice'];
    price = jsonRes['price'];
    tag = jsonRes['tag'];
    title = jsonRes['title'];
    imageList = jsonRes['imageList'] == null ? null : [];

    for (var imageListItem in imageList == null ? [] : jsonRes['imageList']){
      imageList.add(imageListItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"desc": ${desc != null?'${json.encode(desc)}':'null'},"discount": ${discount != null?'${json.encode(discount)}':'null'},"distance": ${distance != null?'${json.encode(distance)}':'null'},"originalPrice": ${originalPrice != null?'${json.encode(originalPrice)}':'null'},"price": ${price != null?'${json.encode(price)}':'null'},"tag": ${tag != null?'${json.encode(tag)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"imageList": $imageList}';
  }
}

class HomeBanner {

  int id;
  int type;
  String imageUrl;
  String title;

  HomeBanner.fromParams({this.id, this.type, this.imageUrl, this.title});

  HomeBanner.fromJson(jsonRes) {
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

