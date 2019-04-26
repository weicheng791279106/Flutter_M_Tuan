
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/conts/conts.dart';
import 'package:m_tuan_flutter/conts/text_size.dart';
import 'package:m_tuan_flutter/model/resp/home_data_resp.dart';
import 'package:m_tuan_flutter/util/http.dart';
import 'package:m_tuan_flutter/util/string_util.dart';
import 'package:m_tuan_flutter/widget/c_circle_avatar.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:banner_view/banner_view.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> {

  /**Banner宽高比*/
  final double BANNER_RATIO = 750 / 200;


  HomeDataResp homeDataResp;


  ///请求主页数据
  Future requestHomeData(BuildContext context) async {
    HomeDataResp response = new HomeDataResp(await Http.post(
        context,
        "http://10.0.4.145:8080/home/homeData",
        new FormData.from({
        })));
    if (response.code != Http.SUCCESS) return;
    setState(() {
      homeDataResp = response;
    });
  }

  @override
  void initState() {
    super.initState();
    requestHomeData(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: CContainer(
        color: CColors.bgDefault,
        direction: Direction.column,
        children: <Widget>[
          CContainer(
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
          ),
          CContainer(
            expand: true,
            gradient: LinearGradient(
              colors: [
                Colors.white,
                CColors.bgDefault,
                CColors.bgDefault,
                CColors.bgDefault,
                CColors.bgDefault,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            child: RefreshIndicator(
              child: ListView.builder(
                itemBuilder: getItemWidget,
                itemCount: 8,
                //controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsetsDirectional.only(bottom: 15),
              ),
              onRefresh: (){
                requestHomeData(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getItemWidget(BuildContext context,int index){
    switch(index){

      case 0:
        return funcWidgets(homeDataResp != null ? homeDataResp.mainFuncList:null);

      case 1:
        return subFuncWidgets(homeDataResp != null ? homeDataResp.subFuncList:null);

      case 2:
        return bannerView();

      case 3:
        return DiscountItemWidget();

      case 4:
        return DiscountItemWidget2();

      case 5:
        return DiscountItemWidget3();

      case 6:
        return MovieWidget();

      case 7:
        return TravelWidget();

    }
  }



  Widget bannerView(){
    double screenWidth = MediaQuery.of(context).size.width;
    double bannerHeight = (screenWidth - 15 * 2) / BANNER_RATIO;
    double bannerCircular = 10;

    List<Widget> widgets = new List();
    widgets.add(CImage(asset: "images/banner_1.png",heiget: bannerHeight,fit: BoxFit.fill,borderRadius: bannerCircular));
    widgets.add(CImage(asset: "images/banner_2.png",heiget: bannerHeight,fit: BoxFit.fill,borderRadius: bannerCircular));
    widgets.add(CImage(asset: "images/banner_3.png",heiget: bannerHeight,fit: BoxFit.fill,borderRadius: bannerCircular));
    widgets.add(CImage(asset: "images/banner_4.png",heiget: bannerHeight,fit: BoxFit.fill,borderRadius: bannerCircular));

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
        indicatorSelected: indicatorItem(CColors.primary, selected: true),
      ),
    );
  }

  Widget indicatorContainer(BuildContext context,Widget indicator) {

    var container = new Container(
      height: 25.0,
      child: new Stack(
        children: <Widget>[
          new Opacity(
            opacity: 0.5,
            child: new Container(
              color: Colors.transparent,
            ),
          ),
          new Align(
            alignment: Alignment.center,
            child: indicator,
          ),
        ],
      ),
    );

    return new Align(
      alignment: Alignment.bottomCenter,
      child: container,
    );
  }

  Widget indicatorItem(Color color, {bool selected = false}) {
    double size = selected ? 6.0 : 6.0;
    return new Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.all(
          new Radius.circular(5.0),
        ),
      ),
    );
  }


  Widget funcWidgets(List<Func> funcList){
    List<Widget> widgetList = List();
    for(Func model in funcList) widgetList.add(TypeWidget(url: model.imageUrl,tag: model.tag,name: model.name));
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

  Widget subFuncWidgets(List<Func> funcList){
    List<Widget> widgetList = List();
    for(Func model in funcList) widgetList.add(SubTypeWidget(name: model.name,url: model.imageUrl,tag: model.tag,));
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

}



class TravelWidget extends StatelessWidget{

  final double IMAGE_RATIO = 270 / 200;

  String bgImageUrl;
  String title;

  String itemTitle1;
  String itemSubTitle1;
  String itemPrice1;
  String itemImage1;
  String itemTitle2;
  String itemSubTitle2;
  String itemPrice2;
  String itemImage2;
  String itemTitle3;
  String itemSubTitle3;
  String itemPrice3;
  String itemImage3;

  @override
  Widget build(BuildContext context) {

    title = "抢酒店5折神劵>";
    bgImageUrl = "images/travel_bg.png";

    itemTitle1 = "曼谷拉查丹利中央酒店";
    itemSubTitle1 = "五一出行特价";
    itemPrice1 = "650.71";
    itemImage1 = "images/travel_1.png";

    itemTitle2 = "曼谷水门伯克利酒店";
    itemSubTitle2 = "五一出行特价";
    itemPrice2 = "408.11";
    itemImage2 = "images/travel_2.jpg";

    itemTitle3 = "彩虹云霄酒店";
    itemSubTitle3 = "五一出行特价";
    itemPrice3 = "392.15";
    itemImage3 = "images/travel_3.jpg";

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
                  itemWidget(context, itemImage1, itemTitle1, itemSubTitle1, itemPrice1),
                  itemWidget(context, itemImage2, itemTitle2, itemSubTitle2, itemPrice2),
                  itemWidget(context, itemImage3, itemTitle3, itemSubTitle3, itemPrice3),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget itemWidget(BuildContext context,String image1,String title,String subTitle,String price){
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
            CImage(asset: image1,borderRadius: 2,width: itemWidth - 5*2,heiget: (itemWidth - 5*2) / IMAGE_RATIO,),
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



class DiscountModel{

  String imageUrl;
  String title;
  String price;
  String discount;

  DiscountModel(this.imageUrl, this.title, this.price, this.discount);

}


class MovieWidget extends StatelessWidget{

  final double IMAGE_RATIO = 300 / 420;

  String imageUrl1;
  String imageUrl2;
  String imageUrl3;
  String movieTitle1;
  String movieTitle2;
  String movieTitle3;
  String movieSubTitle1;
  String movieSubTitle2;
  String movieSubTitle3;

  @override
  Widget build(BuildContext context) {

    imageUrl1 = "images/movie_3.png";
    movieTitle1 = "反贪风暴4";
    movieSubTitle1 = "9.1分";
    imageUrl2 = "images/movie_1.png";
    movieTitle2 = "调音师";
    movieSubTitle2 = "9.2分";
    imageUrl3 = "images/movie_2.png";
    movieTitle3 = "复仇者联盟4：终极之战";
    movieSubTitle3 = "164.4万人想看";


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
            imageWidget(context, imageUrl1, movieTitle1, movieSubTitle1),
            imageWidget(context, imageUrl2, movieTitle2, movieSubTitle2),
            imageWidget(context, imageUrl3, movieTitle3, movieSubTitle3),
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
              CImage(asset: imageUrl,borderRadius: 5,width: imageWidth,heiget: imageWidth / IMAGE_RATIO,),
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

  String title;
  String subTitle;
  String distance;
  String price;
  String originalPrice;
  String discount;
  String imageUrl;

  final double IMAGE_WIDTH = 110;
  final double IMAGE_RATIO = 300 / 250;


  DiscountItemWidget3({this.title, this.subTitle, this.distance, this.price,
      this.originalPrice, this.discount, this.imageUrl});

  @override
  Widget build(BuildContext context) {

    title = "Dream salon梦氏沙龙 【精致剪发】 ";
    subTitle = "仅售68元，价值196元【精致剪发】 资深设计师为你专属定制个性发型";
    distance = "6.8km";
    price = "68";
    originalPrice = "196";
    discount = "3.5折";
    imageUrl = "images/discount_7.png";



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
            CText(title,bold: true,maxLines: 2,textSize: TextSize.Title,),
            CText(subTitle,textColor: Colors.grey[700],maxLines: 1,margin: EdgeInsetsDirectional.only(top: 5,bottom: 5),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CText("￥",textSize: 11,textColor: Color(0xFFFF6644),bold: true,),
                    CText("$price",textSize: 17,textColor:  Color(0xFFFF6644),bold: true,),
                    CText("￥$originalPrice",textColor: Colors.grey,decoration: TextDecoration.lineThrough,margin: EdgeInsetsDirectional.only(start: 3,end: 3),),
                    CContainer(
                      margin: EdgeInsetsDirectional.only(start: 3),
                      padding: EdgeInsetsDirectional.only(top: 1,bottom: 1,start: 4,end: 4),
                      borderRadius: 2,
                      gradient: tagGradient,
                      child: CText(discount,textSize: 11,textColor: Colors.white,),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    CText(distance,maxLines: 1,textColor: Colors.grey[700],margin: EdgeInsetsDirectional.only(end: 10),),
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
            CImage(asset: imageUrl,width: IMAGE_WIDTH,heiget: IMAGE_WIDTH / IMAGE_RATIO,borderRadius: 5,),
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

  String title;
  String subTitle;
  String distance;
  String price;
  String originalPrice;
  String discount;
  List<String> tagList;
  List<String> imageUrlList;


  DiscountItemWidget2({this.title, this.subTitle, this.distance, this.price,
      this.originalPrice, this.discount, this.tagList, this.imageUrlList});

  @override
  Widget build(BuildContext context) {


    title = "Sala hair solon (宝安中心店) (限时抢购)";
    subTitle = "仅售19元，价值298元（限时抢购）总监洗剪+造型，特价优惠等你来";
    distance = "<500m";
    price = "19";
    originalPrice = "298";
    discount = "9.7折";
    tagList = ["销量火爆"];
    imageUrlList = ["images/discount_4.png","images/discount_5.png","images/discount_6.png",];








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
              child:  CText(title,maxLines: 1,bold: true,textSize: TextSize.Title,),
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
              child: CText(subTitle,maxLines: 1,textColor: Colors.grey[700]),
            ),
            CText(distance,maxLines: 1,textColor: Colors.grey[700]),
          ],
        ),
        Row(
          children: <Widget>[
            CText("￥",textSize: 10,textColor: Color(0xFFFF6644),bold: true,),
            CText("$price",textSize: 17,textColor:  Color(0xFFFF6644),bold: true,),
            CText("￥$originalPrice",textColor: Colors.grey,decoration: TextDecoration.lineThrough,),
            CContainer(
              margin: EdgeInsetsDirectional.only(start: 3),
              padding: EdgeInsetsDirectional.only(top: 1,bottom: 1,start: 4,end: 4),
              borderRadius: 2,
              gradient: tagGradient,
              child: CText(discount,textSize: 11,textColor: Colors.white,),
            ),
            Row(
              children: getTagWidgets(),
            ),
          ],
        ),
        CContainer(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Direction.row,
          margin: EdgeInsetsDirectional.only(top: 10),
          children: <Widget>[
            CImage(asset:imageUrlList[0],borderRadius: 5,width: imageWidth,heiget: imageHeight,fit: BoxFit.cover,),
            CImage(asset:imageUrlList[1],borderRadius: 5,width: imageWidth,heiget: imageHeight,fit: BoxFit.cover,),
            CImage(asset:imageUrlList[2],borderRadius: 5,width: imageWidth,heiget: imageHeight,fit: BoxFit.cover,),
          ],
        ),
      ],
    );
  }

  List<Widget> getTagWidgets(){
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

  String tag;
  String title;
  List<DiscountModel> discountModelList;

  DiscountItemWidget({this.tag, this.title, this.discountModelList});

  @override
  Widget build(BuildContext context) {

    tag = "狠优惠";
    title = "折扣商品任你选，好物不间断";
    discountModelList = [
      DiscountModel("images/discount_1.png","平安金融中心云际观光成人票","￥180","5.3折"),
      DiscountModel("images/discount_2.png","大蜀火锅","￥100","5折"),
      DiscountModel("images/discount_3.png","同仁四季","￥128","9折")
    ];

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

  Widget itemWidget(BuildContext context,DiscountModel model){
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = (screenWidth - (15 + 10) * 2) / 3 - 4 /*间隙，需要减掉一点*/;
    double imageHeight = imageWidth * 250 / 300;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            CImage(asset:model.imageUrl,borderRadius: 5,width: imageWidth,heiget: imageHeight,fit: BoxFit.cover,),
            Row(
              children: <Widget>[
                CContainer(
                  leftBottomBorderRadius: 5,
                  //color: Color(0xFFFF5239),
                  gradient: tagGradient,
                  padding: EdgeInsets.all(3),
                  child: CText(model.price,textSize: 11,textColor: Colors.white,bold: true,),
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

///子功能位分类
class SubTypeWidget extends StatelessWidget{

  String tag;
  String name;
  String url;
  String asset;

  SubTypeWidget({this.tag, this.name, this.url, this.asset});

  @override
  Widget build(BuildContext context) {
    double imageWidth = 45.5;
    double imageHeight = 34.5;

    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Column(
              children: <Widget>[
                CImage(url: url,width: imageWidth,heiget: imageHeight,),
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

///主功能位分类
class TypeWidget extends StatelessWidget{

  String tag;
  String name;
  String url;
  String asset;

  TypeWidget({this.tag, this.name, this.url, this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          CContainer(
            margin: EdgeInsetsDirectional.only(top: 2),
            direction: Direction.column,
            children: <Widget>[
              CImage(asset: asset,url: url,width: 58,heiget: 58,),
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




























