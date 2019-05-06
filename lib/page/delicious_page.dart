
import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/model/resp/home_data_resp.dart';
import 'package:m_tuan_flutter/util/navigator_util.dart';
import 'package:m_tuan_flutter/util/string_util.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:m_tuan_flutter/widget/rating_bar.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class DeliciousPage extends StatefulWidget{

  static void startMe(BuildContext context){
      NavigatorUtil.pushWithAnimation(context, DeliciousPage());
  }

  @override
  State<StatefulWidget> createState() {
    return DeliciousPageState();
  }

}

class DeliciousPageState extends State<DeliciousPage>{

  List<DeliciousModel> deliciousList = [
    DeliciousModel(
        imageUrl: "http://10.0.4.145:8080/images/mtuan/discount_6.png",
        isOpen: false,
        title: "潮牛庄牛肉店 · 自家牛场更放心哦",
        isDeliveryable: true,
        isOrderable: true,
        star: 3.5,
        price: "￥76/人",
        distance: "73km",
        local: "西丽",
        classify: "潮汕牛肉火锅",
        populatiry: "当前人气62",
        tagList: ["三好餐厅","西丽牛肉火锅第一名","包间可订","牛肉不错"],
        hotTagSize: 2,
        groupDiscount: "双人餐98元，2-3人餐118元，3-4人餐168元，4-6人餐268元",
        couponDiscount: "85代100元",
        payDiscount: "买单立享满100减5",
        bossSay: "掌柜说：味道不错，服务态度好"
    ),
    DeliciousModel(
        imageUrl: "http://10.0.4.145:8080/images/mtuan/discount_6.png",
        isOpen: false,
        title: "潮牛庄牛肉店 · 自家牛场更放心哦",
        isDeliveryable: true,
        isOrderable: true,
        star: 3.5,
        price: "￥76/人",
        distance: "73km",
        local: "西丽",
        classify: "潮汕牛肉火锅",
        populatiry: "当前人气62",
        tagList: ["三好餐厅","西丽牛肉火锅第一名","包间可订","牛肉不错"],
        hotTagSize: 2,
        groupDiscount: "双人餐98元，2-3人餐118元，3-4人餐168元，4-6人餐268元",
        couponDiscount: "85代100元",
        payDiscount: "买单立享满100减5"
    ),
    DeliciousModel(
        imageUrl: "http://10.0.4.145:8080/images/mtuan/discount_6.png",
        isOpen: false,
        title: "潮牛庄牛肉店 · 自家牛场更放心哦",
        isDeliveryable: true,
        isOrderable: true,
        star: 3.5,
        price: "￥76/人",
        distance: "73km",
        local: "西丽",
        classify: "潮汕牛肉火锅",
        populatiry: "当前人气62",
        tagList: ["三好餐厅","西丽牛肉火锅第一名","包间可订","牛肉不错"],
        hotTagSize: 2,
        groupDiscount: "双人餐98元，2-3人餐118元，3-4人餐168元，4-6人餐268元",
        couponDiscount: "85代100元",
        payDiscount: "买单立享满100减5"
    ),
  ];

  List<Func> mainFuncList = [
    Func.fromParams(name: "优惠团购",imageUrl:"http://10.0.4.145:8080/images/mtuan/ic_type_1.png",tag: "超省"),
    Func.fromParams(name: "附近好券",imageUrl:"http://10.0.4.145:8080/images/mtuan/ic_type_2.png",),
    Func.fromParams(name: "订座",imageUrl:"http://10.0.4.145:8080/images/mtuan/ic_type_3.png",),
    Func.fromParams(name: "晚餐",imageUrl:"http://10.0.4.145:8080/images/mtuan/ic_type_4.png",),
    Func.fromParams(name: "外卖",imageUrl:"http://10.0.4.145:8080/images/mtuan/ic_type_5.png",),
  ];

  List<Func> subFuncList = [
    Func.fromParams(name: "早餐",imageUrl:"http://10.0.4.145:8080/images/mtuan/ic_sub_type_1.png",tag: "超省"),
    Func.fromParams(name: "附近好券",imageUrl:"http://10.0.4.145:8080/images/mtuan/ic_sub_type_2.png",),
    Func.fromParams(name: "订座",imageUrl:"http://10.0.4.145:8080/images/mtuan/ic_sub_type_3.png",),
    Func.fromParams(name: "晚餐",imageUrl:"http://10.0.4.145:8080/images/mtuan/ic_sub_type_4.png",),
    Func.fromParams(name: "外卖",imageUrl:"http://10.0.4.145:8080/images/mtuan/ic_sub_type_5.png",),
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CContainer(
        color:Colors.white,
        direction: Direction.column,
        children: <Widget>[
          TitleBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  MBannerView(),
                  MainFuncWidget(mainFuncList),
                  SubFuncWidget(subFuncList),
                  DiscountWidget(),
                  MyListView(deliciousList),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}


class TitleBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return CContainer(
      padding: EdgeInsets.only(left: 10,right: 15,top: 10,bottom: 10),
      direction: Direction.row,
      children: <Widget>[
        Icon(Icons.arrow_back),
        CContainer(
          expand: true,
          padding: EdgeInsets.only(left: 15,top: 10,right: 10,bottom: 10),
          margin: EdgeInsets.only(left: 15,right: 15),
          color: Colors.grey[100],
          borderRadius: 20,
          child: CText(
            "小龙虾",
            textSize: 13,
            imageAsset: "images/ic_search.png",
            imageScale: 2.0,
            drawableDirection: DrawableDirection.left,
            textColor: Colors.grey,
            drawablePadding: 10,),
        ),
        Icon(Icons.access_time),
      ],
    );
  }

}


class MBannerView extends StatelessWidget{

  /**Banner宽高比*/
  final double BANNER_RATIO = 990 / 280;

  /**当前滚动位置，从1开始*/
  int index = 1;

  List<HomeBanner> bannerList;

  MBannerView({this.bannerList});

  @override
  Widget build(BuildContext context) {
    bannerList = [
      HomeBanner.fromParams(imageUrl:"http://10.0.4.145:8080/images/mtuan/banner_1.png"),
      HomeBanner.fromParams(imageUrl:"http://10.0.4.145:8080/images/mtuan/banner_2.png"),
      HomeBanner.fromParams(imageUrl:"http://10.0.4.145:8080/images/mtuan/banner_3.png"),
    ];

    double screenWidth = MediaQuery.of(context).size.width;
    double bannerHeight = (screenWidth - 15 * 2) / BANNER_RATIO;
    double bannerCircular = 5;

    List<Widget> widgets = new List();
    for(HomeBanner model in bannerList)
      widgets.add(CImage(url: model.imageUrl,heiget: bannerHeight,fit: BoxFit.fill,borderRadius: bannerCircular));

    return Container(
      margin: EdgeInsetsDirectional.only(start: 15,end: 15,top: 10),
      alignment: Alignment.center,
      height: bannerHeight,
      child: BannerView(
        widgets,
        intervalDuration: Duration(seconds: 5),
        indicatorBuilder: indicatorContainer,
        indicatorMargin: 6,
        onPageChanged: (index) {
          /*这里的回调是从1开始，并且在最后一张图滚动回第一张图时会有一个错误的越界回调*/
          if(index > bannerList.length) index = 1;
          this.index = index;
        },
      ),
    );
  }

  Widget indicatorContainer(BuildContext context,Widget indicator) {
    return Container(
      alignment: Alignment.bottomRight,
      child: CContainer(
        mainAxisSize: MainAxisSize.min,
        padding: EdgeInsets.only(left: 5,right: 5,top: 1,bottom: 1),
        margin: EdgeInsets.only(bottom: 4,right: 4),
        borderRadius: 20,
        borderWidth: 0.5,
        borderColor: Colors.grey[600],
        color: Color(0xd8ffffff),
        direction: Direction.row,
        children: <Widget>[
          CText("${index}",textColor: CColors.primary,textSize: 12.5,),
          CText("/${bannerList.length}",textColor: Colors.grey,textSize: 12.5,),
        ],
      ),
    );
  }

}


class MainFuncWidget extends StatelessWidget{

  List<Func> funcList;

  MainFuncWidget(this.funcList);

  @override
  Widget build(BuildContext context) {
    if(funcList == null) return null;
    List<Widget> widgetList = List();
    for(Func model in funcList) widgetList.add(getTypeWidget( model.imageUrl,model.name,model.tag,));
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

  Widget getTypeWidget(String url,String name,String tag,){
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
                CImage(url: url,width: 55,heiget: 55,),
                CText(name, margin: EdgeInsets.all(4),textSize: 12.5,textColor: CColors.textTitle,),
              ],
            ),
            /*标签*/
            CContainer(
              padding: EdgeInsetsDirectional.only(start: 3,end: 3,top: 1,bottom: 1),
              color: StringUtils.isEmpty(tag) ? Colors.transparent:Color.fromARGB(255, 250, 110, 70),
              borderRadius: 10,
              leftBottomBorderRadius: 0,
              borderWidth: 0.5,
              borderColor: Colors.white,
              child: CText(tag,textSize: 9,textColor: Colors.white,),
            ),
          ],
        ),
      ),
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
    for(Func model in funcList) widgetList.add(getTypeWidget(model.imageUrl, model.name, model.tag,));
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

  Widget getTypeWidget(String url,String name,String tag){
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
              color: !StringUtils.isEmpty(tag) ? Color.fromARGB(255, 250, 110, 70):Colors.transparent,
              padding: EdgeInsetsDirectional.only(start: 3,end: 3,top: 1,bottom: 1),
              borderRadius: 20,
              leftBottomBorderRadius: 0,
              child: CText(tag,textSize: 8,textColor: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }

}


class MyListView extends StatelessWidget{

  List<DeliciousModel> data;

  MyListView(this.data);

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: FilterWidget(),
      content: CContainer(
        child: RefreshIndicator(
          child: ListView.builder(
            itemBuilder: (c,index) => DeliciousWidget(data[index],index != 0),
            itemCount: data.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
          onRefresh: () => null,
        ),
      ),
    );
  }

}


class DiscountWidget extends StatelessWidget{

  List<Discount> discountList;

  @override
  Widget build(BuildContext context) {
    discountList = [
      Discount.fromParams(title: "百果园（豪景城店哈哈哈哈哈哈）",price:"27",tag: "秒杀 11:00开秒",imageList: ["http://10.0.4.145:8080/images/mtuan/discount_6.png"]),
      Discount.fromParams(title: "尊宝比萨（后瑞店）",price:"27",imageList: ["http://10.0.4.145:8080/images/mtuan/discount_2.png"]),
      Discount.fromParams(title: "正新鸡排（深圳华侨城店）",price:"27",imageList: ["http://10.0.4.145:8080/images/mtuan/discount_3.png"]),
      Discount.fromParams(title: "正新鸡排（深圳华侨城店）",price:"27",imageList: ["http://10.0.4.145:8080/images/mtuan/discount_3.png"]),
      Discount.fromParams(title: "正新鸡排（深圳华侨城店）",price:"27",imageList: ["http://10.0.4.145:8080/images/mtuan/discount_3.png"]),
      Discount.fromParams(title: "正新鸡排（深圳华侨城店）",price:"27",imageList: ["http://10.0.4.145:8080/images/mtuan/discount_3.png"]),
      Discount.fromParams(title: "正新鸡排（深圳华侨城店）",price:"27",imageList: ["http://10.0.4.145:8080/images/mtuan/discount_3.png"]),
    ];


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CText("超值优惠",bold: true,textSize: 20,padding: EdgeInsets.only(left: 15,top: 16,bottom: 3),),
        SizedBox(
          height: 130,
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: ListView.builder(
              itemBuilder: getItemWidget,
              itemCount: discountList.length,
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
            ),
          ),
        ),
      ],
    );

  }

  Widget getItemWidget(BuildContext context,int index){
    Discount model = discountList[index];
    return Stack(
      children: <Widget>[
        CContainer(
          width: 120,
          margin: EdgeInsets.only(top: 5,right: 10),
          direction: Direction.column,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CImage(url: model.imageList[0],borderRadius: 4,heiget: 85),
            CText(model.title,),
            Row(
              children: <Widget>[
                CText("￥",textSize: 12,textColor: Color.fromARGB(255, 255, 153, 0)),
                CText("${model.price}",textSize: 18,textColor: Color.fromARGB(255, 255, 153, 0)),
              ],
            ),
          ],
        ),
        CContainer(
          borderRadius: 15,
          borderColor: Colors.white,
          borderWidth: 0.8,
          leftBottomBorderRadius: 0,
          color: StringUtils.isEmpty(model.tag) ? Colors.transparent:Color.fromARGB(255, 255, 75, 16),
          padding: EdgeInsets.only(left: 6,right: 6,top: 1,bottom: 1),
          child: CText(model.tag,textColor: Colors.white,textSize: 11,),
        )
      ],
    );
  }

}


class FilterWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return CContainer(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Direction.row,
      children: <Widget>[
        CText("全部美食",textSize:13,icon: Icons.arrow_drop_down,iconSize: 17,textColor: Colors.grey[700],),
        CText("附近",textSize:13,icon: Icons.arrow_drop_down,iconSize: 17,textColor: Colors.grey[700],),
        CText("智能排序",textSize:13,icon: Icons.arrow_drop_down,iconSize: 17,textColor: Colors.grey[700],),
        CText("筛选",textSize:13,icon: Icons.arrow_drop_down,iconSize: 17,textColor: Colors.grey[700],),
      ],
    );
  }

}


class DeliciousWidget extends StatelessWidget{

  DeliciousModel model;
  bool topDivider;


  DeliciousWidget(this.model,this.topDivider);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Offstage(
          offstage: !topDivider,
          child: Divider(height: 0.1,color: Colors.grey[200],indent: 15,),
        ),
        CContainer(
          padding: EdgeInsets.only(left: 15,right: 10,top: 20,bottom: 20),
          direction: Direction.row,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CImage(url: model.imageUrl,width: 60,heiget: 60,borderRadius: 2,),
                SizedBox(height: 5),
                CText("休息中",textColor:Colors.grey,textSize:10,icon: Icons.restore,drawableDirection: DrawableDirection.left,iconSize: 10,drawablePadding: 3,)
              ],
            ),
            CContainer(
              expand: true,
              margin: EdgeInsets.only(left: 10),
              direction: Direction.column,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /*标题行*/
                Row(
                  children: <Widget>[
                    Expanded(child:  CText(model.title,textSize: 16,bold: true,),),
                    !model.isDeliveryable ? null:
                    CContainer(
                      borderWidth: 0.5,
                      borderColor: Color.fromARGB(255, 255, 153, 0),
                      borderRadius: 1,
                      padding: EdgeInsets.only(left: 1.5,right: 1.5),
                      child: CText("外",textSize:13,textColor: Color.fromARGB(255, 255, 153, 0),),
                    ),
                    !model.isOrderable ? null:
                    CContainer(
                      borderWidth: 0.5,
                      borderColor: Color.fromARGB(255, 94, 178, 43),
                      borderRadius: 1,
                      padding: EdgeInsets.only(left: 1.5,right: 1.5),
                      margin: EdgeInsets.only(left: 5),
                      child: CText("订",textSize:13,textColor: Color.fromARGB(255, 94, 178, 43)),
                    ),
                  ],
                ),
                /*评分行*/
                CContainer(
                  padding: EdgeInsets.only(top: 5,bottom: 5),
                  direction: Direction.row,
                  children: <Widget>[
                    RatingBar(model.star),
                    Expanded(child: CText(model.price,textColor: Colors.grey[700],)),
                    CText(model.distance,textColor: Colors.grey[700],),
                  ],
                ),
                /*位置行*/
                Row(
                  children: <Widget>[
                    Expanded(child: CText("${model.local} | ${model.classify}",textColor: Colors.grey[700],),),
                    CText(model.populatiry,textColor: Color.fromARGB(255, 255, 153, 0),)
                  ],
                ),
                /*标签行*/
                CContainer(
                  padding: EdgeInsets.only(top: 5,bottom: 5),
                  direction: Direction.row,
                  children: tagWidgets(),
                ),
                /*掌柜说*/
                Offstage(
                  offstage: StringUtils.isEmpty(model.bossSay),
                  child: CText(model.bossSay,textColor: Colors.grey,),
                ),
                /*团购折扣*/
                Offstage(
                  offstage: StringUtils.isEmpty(model.groupDiscount),
                  child: CContainer(
                    direction: Direction.row,
                    margin: EdgeInsets.only(top: 10),
                    children: <Widget>[
                      CContainer(
                        borderRadius: 1,
                        padding: EdgeInsets.only(left: 1.5,right: 1.5),
                        margin: EdgeInsets.only(right: 5),
                        color: CColors.primary,
                        child: CText("团",textColor: Colors.white,),
                      ),
                      Expanded(child:CText(model.groupDiscount,textColor: Colors.grey[700],))
                    ],
                  ),
                ),
                /*优惠券折扣*/
                Offstage(
                  offstage: StringUtils.isEmpty(model.couponDiscount),
                  child: CContainer(
                    direction: Direction.row,
                    margin: EdgeInsets.only(top: 10),
                    children: <Widget>[
                      CContainer(
                        borderRadius: 1,
                        padding: EdgeInsets.only(left: 1.5,right: 1.5),
                        margin: EdgeInsets.only(right: 5),
                        color: Color.fromARGB(255, 255, 135, 32),
                        child: CText("券",textColor: Colors.white,),
                      ),
                      Expanded(child: CText(model.couponDiscount,textColor: Colors.grey[700],),)
                    ],
                  ),
                ),
                /*团购折扣*/
                Offstage(
                  offstage: StringUtils.isEmpty(model.payDiscount),
                  child: CContainer(
                    direction: Direction.row,
                    margin: EdgeInsets.only(top: 10),
                    children: <Widget>[
                      CContainer(
                        borderRadius: 1,
                        padding: EdgeInsets.only(left: 1.5,right: 1.5),
                        margin: EdgeInsets.only(right: 5),
                        color: Color.fromARGB(255, 255, 114, 0),
                        child: CText("买",textColor: Colors.white,),
                      ),
                      Expanded(child: CText(model.payDiscount,textColor: Colors.grey[700],),)
                    ],
                  ),
                ),

              ],
            )
          ],
        )
      ],
    );
  }

  List<Widget> tagWidgets(){
    List<Widget> tagWidgetList = [];
    int index = 1;
    for(String tag in model.tagList){
      Color color = index <= model.hotTagSize ? Color.fromARGB(255, 255, 153, 0):Colors.grey;
      tagWidgetList.add(
        CContainer(
          padding: EdgeInsets.only(left: 2,right: 2),
          borderRadius: 1,
          borderWidth: 0.5,
          borderColor: color,
          margin: EdgeInsets.only(right: 2.5),
          child: CText(tag,textColor: color,textSize: 11,),
        )
      );
      index++;
    }
    return tagWidgetList;
  }

}

class DeliciousModel{

  DeliciousModel({this.imageUrl, this.title, this.tagList, this.star, this.price,
      this.distance, this.local, this.classify, this.populatiry,
      this.hotTagSize, this.groupDiscount, this.couponDiscount,
      this.payDiscount, this.bossSay, this.isOpen, this.isDeliveryable,
      this.isOrderable});

  String imageUrl;
  String title;
  List<String> tagList;
  double star;
  String price;
  String distance;
  String local;
  String classify;
  String populatiry;
  int hotTagSize;
  String groupDiscount;
  String couponDiscount;
  String payDiscount;
  String bossSay;
  bool isOpen = true;
  bool isDeliveryable = true;
  bool isOrderable = true;

}





































