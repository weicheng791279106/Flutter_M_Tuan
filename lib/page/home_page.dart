
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/conts/conts.dart';
import 'package:m_tuan_flutter/conts/text_size.dart';
import 'package:m_tuan_flutter/model/resp/home_data_resp.dart';
import 'package:m_tuan_flutter/page/delicious_page.dart';
import 'package:m_tuan_flutter/util/http.dart';
import 'package:m_tuan_flutter/util/string_util.dart';
import 'package:m_tuan_flutter/widget/c_circle_avatar.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:banner_view/banner_view.dart';
import 'package:m_tuan_flutter/widget/loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  /**缓存Key*/
  final key_resp_data = "key_home_resp_data";

  HomeDataResp homeDataResp;

  @override
  bool get wantKeepAlive => true;

  ///请求主页数据
  Future requestHomeData(BuildContext context) async {
    String respStr = await Http.post(
        context,
        "home/homeData",
        new FormData.from({}));
    HomeDataResp response = HomeDataResp(respStr);
    if (response.code != Http.SUCCESS) return ;
    /*缓存数据*/
    await SharedPreferences.getInstance()..setString(key_resp_data, respStr);
    /*更新UI*/
    setState(() => homeDataResp = response);
  }

  @override
  void initState() {
    super.initState();
    requestHomeData(context);
    /**读取缓存*/
    SharedPreferences.getInstance().then((prefs) => setState(()=> homeDataResp = HomeDataResp(prefs.get(key_resp_data))));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: CContainer(
        color: CColors.bgDefault,
        direction: Direction.column,
        children: <Widget>[
          TitleBar(),
          MyScrollView(homeDataResp,callback:() => requestHomeData(context)),
        ],
      ),
    );
  }

}


class TitleBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return CContainer(
      padding: EdgeInsetsDirectional.only(start: 15,top: 10,bottom: 10,end: 15),
      direction: Direction.row,
      color: Colors.white,
      children: <Widget>[
        CCircleAvatar("",width: 35,height: 35),
        CContainer(
          direction: Direction.column,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: EdgeInsetsDirectional.only(start: 12),
          children: <Widget>[
            CText("深圳",textSize:15.5,bold:true,icon: Icons.keyboard_arrow_down,iconSize: 17,),
            CText("多云 27°",textSize: 10,margin: EdgeInsetsDirectional.only(top: 5),)
          ],
        ),
        CContainer(
          expand: true,
          padding: EdgeInsetsDirectional.only(top: 12,bottom: 12),
          margin: EdgeInsetsDirectional.only(start: 10,end: 15),
          alignment: Alignment.center,
          color: Colors.grey[100],
          borderRadius: 10,
          child: CText(
            "大汉堡",
            imageAsset: "images/ic_search.png",
            imageScale: 2.3,
            drawableDirection: DrawableDirection.left,
            textColor: Colors.grey,
            drawablePadding: 5,),
        ),
        Icon(Icons.add,size: 30,),
      ],
    );
  }

}

class MyScrollView extends StatelessWidget{

  HomeDataResp homeDataResp;

  RefreshCallback callback;

  /**
   * callback:下拉刷新回调
   * */
  MyScrollView(this.homeDataResp,{this.callback});

  /**渐变背景*/
  var gradient = LinearGradient(
    colors: [
      Colors.white,
      CColors.bgDefault,
      CColors.bgDefault,
      CColors.bgDefault,
      CColors.bgDefault,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    if(homeDataResp == null) return LoadingWidget();
    return CContainer(
      expand: true,
      gradient: gradient,
      child: RefreshIndicator(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 15),
            child: Column(
              children: <Widget>[
                MainFuncWidget(homeDataResp.mainFuncList),
                SubFuncWidget(homeDataResp.subFuncList),
                MyBannerView(homeDataResp.bannerList),
                MyListView(homeDataResp.discountList),
                MovieWidget(homeDataResp.movieList),
                HotelWidget(homeDataResp.hotelList),
              ],
            ),
          ),
        onRefresh: callback,
      )
    );
  }

}

class MyListView extends StatelessWidget{

  List<DiscountItem> discountItemList;

  MyListView(this.discountItemList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: getItemWidget,
      itemCount: discountItemList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  Widget getItemWidget(BuildContext context,int index){
    DiscountItem model = discountItemList[index];
    switch(model.type){
      case 1:
        return DiscountItemWidget(model.title,model.discountList);
      case 2:
        return DiscountItemWidget2(model.discountList[0]);
      case 3:
        return DiscountItemWidget3(model.discountList[0]);
    }
  }

}


class MainFuncWidget extends StatelessWidget{

  List<Func> funcList;

  MainFuncWidget(this.funcList);

  @override
  Widget build(BuildContext context) {
    if(funcList == null) return null;
    List<Widget> widgetList = List();
    for(Func model in funcList) widgetList.add(getFuncWidget(context,model.imageUrl,model.name,model.tag));
    return GridView.count(
      padding: EdgeInsets.only(left: 15, right: 15,top: 15),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 5,
      mainAxisSpacing: 17,
      childAspectRatio: 0.75,
      children: widgetList,
    );
  }

  Widget getFuncWidget(BuildContext context,String imageUrl,String name,String tag){
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            CContainer(
              margin: EdgeInsetsDirectional.only(top: 2),
              direction: Direction.column,
              children: <Widget>[
                CImage(url: imageUrl,width: 58,heiget: 58,),
                CText(name, margin: EdgeInsets.all(4),textSize: 12.5,textColor: CColors.textTitle,),
              ],
            ),
            /*标签*/
            CContainer(
              padding: EdgeInsetsDirectional.only(start: 4,end: 4,top: 1,bottom: 1),
              color: StringUtils.isEmpty(tag) ? Colors.transparent:Colors.red,
              borderRadius: 10,
              child: CText(tag,textSize: 10,textColor: Colors.white,),
            ),
          ],
        ),
      ),
      onTap: (){
        switch(name){

          case "美食":
            DeliciousPage.startMe(context);
            break;

        }
      },
    );
  }

}

class SubFuncWidget extends StatelessWidget{

  final double imageWidth = 45.5;
  final double imageHeight = 34.5;

  List<Func> funcList;

  SubFuncWidget(this.funcList);

  @override
  Widget build(BuildContext context) {
    if(funcList == null) return null;
    List<Widget> widgetList = List();
    for(Func model in funcList) widgetList.add(getFuncWidget( model.imageUrl,model.name, model.tag,));
    return GridView.count(
      padding: EdgeInsets.only(left: 15, right: 15,top: 15),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 5,
      mainAxisSpacing: 0,
      childAspectRatio: 1.0,
      children: widgetList,
    );
  }

  Widget getFuncWidget(String imageUrl,String name,String tag){
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Column(
              children: <Widget>[
                CImage(url: imageUrl,width: imageWidth,heiget: imageHeight,),
                CText(name,textSize: 12.5,textColor: CColors.textTitle,),
              ],
            ),
            CContainer(
              color: !StringUtils.isEmpty(tag) ? Colors.red:Colors.transparent,
              padding: EdgeInsetsDirectional.only(start: 4,end: 4,top: 1,bottom: 1),
              borderRadius: 20,
              leftBottomBorderRadius: 0,
              child: CText(tag,textSize: 10,textColor: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }


}



class MyBannerView extends StatelessWidget{

  /**Banner宽高比*/
  final double BANNER_RATIO = 750 / 200;

  List<HomeBanner> bannerList;

  MyBannerView(this.bannerList);

  @override
  Widget build(BuildContext context) {
    if(bannerList == null) return null;

    double screenWidth = MediaQuery.of(context).size.width;
    double bannerHeight = (screenWidth - 15 * 2) / BANNER_RATIO;
    double bannerCircular = 10;

    List<Widget> widgets = new List();
    for(HomeBanner model in bannerList)
      widgets.add(CImage(url: model.imageUrl,heiget: bannerHeight,fit: BoxFit.fill,borderRadius: bannerCircular));

    return Container(
      margin: EdgeInsetsDirectional.only(start: 15,end: 15,top: 18),
      alignment: Alignment.center,
      height: bannerHeight,
      child: BannerView(
        widgets,
        intervalDuration: Duration(seconds: 3),
        indicatorBuilder: indicatorContainer,
        indicatorMargin: 6,
        indicatorNormal: indicatorItem(Color(0x7FEEEEEE)),
        indicatorSelected: indicatorItem(CColors.primary, selected: true,),
        log: false,
      ),
    );
  }

  Widget indicatorContainer(BuildContext context,Widget indicator) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 25.0,
        child:  Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.5,
              child: new Container(
                color: Colors.transparent,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: indicator,
            ),
          ],
        ),
      ),
    );
  }

  Widget indicatorItem(Color color, {bool selected = false}) {
    double size = selected ? 6.0 : 6.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(5.0),),
      ),
    );
  }

}



class HotelWidget extends StatelessWidget{

  final double IMAGE_RATIO = 270 / 200;

  String bgImageUrl = "images/travel_bg.png";
  String title = "抢酒店5折神劵>";
  List<Hotel> hotelList;

  HotelWidget(this.hotelList);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 15,end: 15,top: 10),
      child: Stack(
        children: <Widget>[
          CImage(asset: bgImageUrl,borderRadius: 10,),
          CContainer(
            padding: EdgeInsets.all(10),
            direction: Direction.column,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: CText(title,textColor: Colors.white,bold: true,textSize: TextSize.Title,)),
                  CImage(asset: "images/ic_close_item.png",scale: 1.8,),
                ],
              ),
              CContainer(
                margin: EdgeInsetsDirectional.only(top: 10),
                direction: Direction.row,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  itemWidget(context, hotelList[0].imageUrl, hotelList[0].name, hotelList[0].tag, hotelList[0].price),
                  itemWidget(context, hotelList[1].imageUrl, hotelList[1].name, hotelList[1].tag, hotelList[1].price),
                  itemWidget(context, hotelList[2].imageUrl, hotelList[2].name, hotelList[2].tag, hotelList[2].price),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget itemWidget(BuildContext context,String imageUrl,String title,String subTitle,String price){
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = (screenWidth - 15*2 - 10*2 - 5*2) / 3;
    return CContainer(
      color: Colors.white,
      borderRadius: 5,
      direction: Direction.column,
      width: itemWidth,
      padding: EdgeInsetsDirectional.only(start: 5,end: 5,top: 5,bottom: 10),
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            CImage(url: imageUrl,borderRadius: 2,width: itemWidth - 5*2,heiget: (itemWidth - 5*2) / IMAGE_RATIO,),
            CContainer(
              color: Color(0x99000000),
              leftBottomBorderRadius: 2,
              rightTopBorderRadius: 2,
              padding: EdgeInsetsDirectional.only(start: 3,end: 3,top: 1,bottom: 1),
              child: CText(subTitle,textColor: Colors.white,textSize: 10,),
            )
          ],
        ),
        CText(title,bold: true,margin: EdgeInsetsDirectional.only(top: 6,bottom: 4),maxLines: 1,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CText("￥" + price,textColor: Colors.redAccent,textSize: 11,bold: true,),
            CText(" /人",textColor: Colors.grey,textSize: 11,),
          ],
        ),
      ],
    );
  }

}


class MovieWidget extends StatelessWidget{

  final double IMAGE_RATIO = 300 / 420;

  List<Movie> movieList;

  MovieWidget(this.movieList);

  @override
  Widget build(BuildContext context) {
    return CContainer(
      color: Colors.white,
      margin: EdgeInsetsDirectional.only(start: 15,end: 15,top: 10),
      padding: EdgeInsets.all(10.0),
      borderRadius: 10,
      direction: Direction.column,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CText("正在热映影片",bold: true,textSize: TextSize.Title,),
            CImage(asset: "images/ic_close_item.png",scale: 1.8,),
          ],
        ),
        CContainer(
          margin: EdgeInsetsDirectional.only(top: 10),
          direction: Direction.row,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            imageWidget(context, movieList[0].imageUrl, movieList[0].title, movieList[0].score),
            imageWidget(context, movieList[1].imageUrl, movieList[1].title, movieList[1].score),
            imageWidget(context, movieList[2].imageUrl, movieList[2].title, movieList[2].score),
          ],
        ),
      ],
    );
  }

  Widget imageWidget(BuildContext context,String imageUrl,String title,String subTitle){
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = (screenWidth - 15*2 - 10*2 - 5*2) / 3;

    return SizedBox(
      width: imageWidth,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              CImage(url: imageUrl,borderRadius: 5,width: imageWidth,heiget: imageWidth / IMAGE_RATIO,),
              CContainer(
                width: imageWidth,
                leftBottomBorderRadius: 5,
                rightBottomBorderRadius: 5,
                padding: EdgeInsetsDirectional.only(top: 5,bottom: 5,),
                alignment: Alignment.center,
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0x00000000),
                    Color(0x66000000),
                    Color(0xCC000000),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                child: CText(subTitle,textColor: Colors.white,bold: true,),
              )
            ],
          ),
          CText(title,margin: EdgeInsetsDirectional.only(top: 9,start: 3,end: 3),bold: true,)
        ],
    ),);
  }

}


class DiscountItemWidget3 extends StatelessWidget{

  Discount model;

  final double IMAGE_WIDTH = 110;
  final double IMAGE_RATIO = 300 / 250;


  DiscountItemWidget3(this.model,);

  @override
  Widget build(BuildContext context) {
    return CContainer(
      color: Colors.white,
      margin: EdgeInsetsDirectional.only(start: 15,end: 15,top: 10),
      padding: EdgeInsetsDirectional.only(start: 10,end: 10,top: 17 ,bottom: 17),
      borderRadius: 10,
      direction: Direction.row,
      children: <Widget>[
        CContainer(
          margin: EdgeInsetsDirectional.only(end: 10),
          expand: true,
          direction: Direction.column,
          children: <Widget>[
            CText(model.title,bold: true,maxLines: 2,textSize: TextSize.Title,),
            CText(model.desc,textColor: Colors.grey[700],maxLines: 1,margin: EdgeInsetsDirectional.only(top: 5,bottom: 5),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CText("￥",textSize: 11,textColor: Color(0xFFFF6644),bold: true,),
                    CText("${model.price}",textSize: 17,textColor:  Color(0xFFFF6644),bold: true,),
                    CText("￥${model.originalPrice}",textColor: Colors.grey,decoration: TextDecoration.lineThrough,margin: EdgeInsetsDirectional.only(start: 3,end: 3),),
                    CContainer(
                      margin: EdgeInsetsDirectional.only(start: 3),
                      padding: EdgeInsetsDirectional.only(top: 1,bottom: 1,start: 4,end: 4),
                      borderRadius: 2,
                      gradient: tagGradient,
                      child: CText(model.discount,textSize: 11,textColor: Colors.white,),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    CText(model.distance,maxLines: 1,textColor: Colors.grey[700],margin: EdgeInsetsDirectional.only(end: 10),),
                    CImage(asset: "images/ic_close_item.png",scale: 1.8,)
                  ],
                ),
              ],
            ),
          ],
        ),
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            CImage(url: model.imageList[0],width: IMAGE_WIDTH,heiget: IMAGE_WIDTH / IMAGE_RATIO,borderRadius: 5,),
            CContainer(
              color: Color(0x33000000),
              borderRadius: 5,
              borderWidth: 0,
              leftBottomBorderRadius: 0,
              rightTopBorderRadius: 0,
              padding: EdgeInsetsDirectional.only(start: 3,end: 3,top: 2,bottom: 2),
              child: CText("广告",textColor: Colors.white,textSize: 10,),
            )
          ],
        ),
      ],
    );
  }

}


///折扣Item，第二种类型
class DiscountItemWidget2 extends StatelessWidget{

  Discount model;

  DiscountItemWidget2(this.model);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = (screenWidth - (15 + 10) * 2) / 3 - 4 /*间隙，需要减掉一点*/;
    double imageHeight = imageWidth * 250 / 300;

    return CContainer(
      color: Colors.white,
      margin: EdgeInsetsDirectional.only(start: 15,end: 15,top: 10),
      padding: EdgeInsets.all(10.0),
      borderRadius: 10,
      direction: Direction.column,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CContainer(
              expand: true,
              child:  CText(model.title,maxLines: 1,bold: true,textSize: TextSize.Title,),
            ),
            CImage(asset: "images/ic_close_item.png",scale: 1.8,)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CContainer(
              expand: true,
              margin: EdgeInsetsDirectional.only(top: 5,bottom: 5),
              child: CText(model.desc,maxLines: 1,textColor: Colors.grey[700]),
            ),
            CText(model.distance,maxLines: 1,textColor: Colors.grey[700]),
          ],
        ),
        Row(
          children: <Widget>[
            CText("￥",textSize: 10,textColor: Color(0xFFFF6644),bold: true,),
            CText("${model.price}",textSize: 17,textColor:  Color(0xFFFF6644),bold: true,),
            CText("￥${model.originalPrice}",textColor: Colors.grey,decoration: TextDecoration.lineThrough,),
            CContainer(
              margin: EdgeInsetsDirectional.only(start: 3),
              padding: EdgeInsetsDirectional.only(top: 1,bottom: 1,start: 4,end: 4),
              borderRadius: 2,
              gradient: tagGradient,
              child: CText(model.discount,textSize: 11,textColor: Colors.white,),
            ),
            Row(
              children: getTagWidgets([model.tag]),
            ),
          ],
        ),
        CContainer(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Direction.row,
          margin: EdgeInsetsDirectional.only(top: 10),
          children: <Widget>[
            CImage(url:model.imageList[0],borderRadius: 5,width: imageWidth,heiget: imageHeight,fit: BoxFit.cover,),
            CImage(url:model.imageList[1],borderRadius: 5,width: imageWidth,heiget: imageHeight,fit: BoxFit.cover,),
            CImage(url:model.imageList[2],borderRadius: 5,width: imageWidth,heiget: imageHeight,fit: BoxFit.cover,),
          ],
        ),
      ],
    );
  }

  List<Widget> getTagWidgets(List<String> tagList){
    List<Widget> tagWidgetList = new List();
    if(tagList == null) return tagWidgetList;
    for (var tag in tagList) {
      tagWidgetList.add(
          CContainer(
            margin: EdgeInsetsDirectional.only(start: 3),
            padding: EdgeInsetsDirectional.only(start: 2,end: 2),
            borderRadius: 2,
            borderColor: Colors.grey[300],
            borderWidth: 0.5,
            color: Colors.white,
            child: CText(tag,textSize:11,textColor: Colors.grey[700],padding: EdgeInsets.all(1),),
          )
      );
    }
    return tagWidgetList;
  }

}


///折扣Item
class DiscountItemWidget extends StatelessWidget{

  String tag = "狠优惠";
  String title;
  List<Discount> discountModelList;

  DiscountItemWidget(this.title, this.discountModelList);

  @override
  Widget build(BuildContext context) {
    return CContainer(
      margin: EdgeInsetsDirectional.only(start: 15,end: 15,top: 10),
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      borderRadius: 10,
      direction: Direction.column,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CContainer(
          direction: Direction.row,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CContainer(
              mainAxisSize: MainAxisSize.min,
              borderRadius: 8,
              color: Colors.grey[100],
              padding: EdgeInsetsDirectional.only(start: 10,end: 10,top: 2,bottom: 2),
              child: CText(
                tag,
                textColor: Color(0xFFFF4A4A),
                textSize: 13,
                bold: true,
                imageAsset: "images/ic_arrow_right_discount.png",
                drawablePadding: 4,
                imageScale: 2.8,
              ),
            ),
            CImage(asset: "images/ic_close_item.png",scale: 1.8,)
          ],
        ),
        CText(title,textColor: Colors.grey[800],padding: EdgeInsetsDirectional.only(top: 6,bottom: 6),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            itemWidget(context,discountModelList[0]),
            itemWidget(context,discountModelList[1]),
            itemWidget(context,discountModelList[2]),
          ],
        ),
      ],
    );
  }

  Widget itemWidget(BuildContext context,Discount model){
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = (screenWidth - (15 + 10) * 2) / 3 - 4 /*间隙，需要减掉一点*/;
    double imageHeight = imageWidth * 250 / 300;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            CImage(url:model.imageList[0],borderRadius: 5,width: imageWidth,heiget: imageHeight,fit: BoxFit.cover,),
            Row(
              children: <Widget>[
                CContainer(
                  leftBottomBorderRadius: 5,
                  //color: Color(0xFFFF5239),
                  gradient: tagGradient,
                  padding: EdgeInsets.all(3),
                  child: CText("￥" + model.price,textSize: 11,textColor: Colors.white,bold: true,),
                ),
                CContainer(
                  color: Colors.black,
                  rightTopBorderRadius: 5,
                  padding: EdgeInsets.all(3),
                  child: CText(model.discount,textSize: 11,textColor: Colors.white,bold: true,),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          width: imageWidth,
          child: CText(
            model.title,
            textColor: Colors.black,
            bold: true,
            maxLines: 2,
            padding: EdgeInsetsDirectional.only(top: 5),
          ),),
      ],
    );
  }

}


///红色的渐变标签背景
LinearGradient tagGradient = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: <Color>[
    Color.fromARGB(255,255,103,68),
    Color.fromARGB(255,255,74,53),
  ],
);




























