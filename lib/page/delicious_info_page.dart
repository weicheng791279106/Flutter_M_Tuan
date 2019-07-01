
import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/util/navigator_util.dart';
import 'package:m_tuan_flutter/widget/c_circle_avatar.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_stateful_widget.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:m_tuan_flutter/widget/rating_bar.dart';

/**美食详情页*/
class DeliciousInfoPage extends CStatefulWidget{

  static void startMe(BuildContext context){
    NavigatorUtil.pushWithAnimation(context, DeliciousInfoPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:(context,innerBoxIsScrolled) => <Widget>[
            MyAppBar(),
          ],
          body: Column(
            children: <Widget>[
              BodyWidget(),
              BottomWidget(),
            ],
          ),
        ),
      ),
    );
  }

}


class MyAppBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color:Colors.grey,
      ),
      actions: <Widget>[
        Icon(Icons.share),
        SizedBox(width: 10,),
        Icon(Icons.star),
        PopupMenuButton(
          icon: Icon(Icons.more_horiz),
          itemBuilder: (BuildContext context) =><PopupMenuItem<String>>[
            PopupMenuItem(
              child: CText("首页"),
            ),
          ],
        )
      ],
    );
  }

}

class BodyWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              CContainer(
                color: Colors.white,
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: Direction.column,
                padding: EdgeInsets.only(top: 10,bottom: 10),
                children: <Widget>[
                  DeliciousInfoWidget(),
                  RecommendWidget(),
                  CContainer(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    direction: Direction.column,
                    padding: EdgeInsets.only(top:15,left: 10,right: 10,bottom: 15),
                    children: <Widget>[
                      RestaurantInfoWidget(),
                      CommentWidget(),
                    ],
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }

}

class DeliciousInfoWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return CContainer(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Direction.column,
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 15),
      children: <Widget>[
        CText("肯德基（壹方城店）",icon: Icons.keyboard_arrow_right,),
        CText("【经典单人餐Y8】",textSize: 22,bold: true,),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CText("随时退 | 免预约 | 过期退",textColor: Colors.grey,),
            CText("半年销量 8.5W+",textColor: Colors.grey,),
          ],
        ),
        SizedBox(height: 10,),
        CImage(asset: "images/discount_5.png",),
        SizedBox(height: 10,),
        CText("Y8",textSize: 14,),
        SizedBox(height: 5,),
        FoodWidget("香辣鸡腿堡",1,17,true,),
        FoodWidget("新奥尔良烤翅",1,12,true),
        FoodWidget("百事可乐",1,9,false),
        SizedBox(height: 20,),
        CText("温馨提示",bold: true,textSize: 20,),
        SizedBox(height: 10,),
        CText("有效期：\n• 2018.11.26至2019.12.31（周末、法定节假日通用）\n"
            "使用时间：\n• 营业时间段内"
            "使用规则：\n• 本卷不适用于肯德基宅急送及甜品站\n• 团购用户不可同时享受商家其它优惠"
            "\n• 酒水饮料等问题，请致电商家咨询，以商家反馈为准",
          textSize: 14,
          lineHeight: 1.7,
        ),
      ],
    );
  }

}

class FoodWidget extends StatelessWidget{

  String name;
  int num;
  bool isRecommend;
  double price;

  FoodWidget(this.name, this.num,this.price, this.isRecommend,);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3,bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CText(name,textSize: 13,),
              CText("（$num份）",textColor: Colors.grey,),
              Offstage(
                offstage: !isRecommend,
                child: CContainer(
                  leftBottomBorderRadius: 0,
                  borderRadius: 10,
                  borderColor: CColors.orange,
                  borderWidth: 0.5,
                  padding: EdgeInsets.only(left: 5,right: 5,top: 1,bottom: 1),
                  color: Color.fromARGB(255, 255, 249, 237),
                  child: CText("网友推荐",textColor: CColors.orange,textSize: 10,),
                ),
              ),
            ],
          ),
          CText("¥$price",textSize: 13,)
        ],
      ),
    );
  }

}

class RecommendWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CColors.bgDefault,
      child: CContainer(
        color: Colors.white,
        direction: Direction.column,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 10),
        borderRadius: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CText("推荐搭配",bold: true,textSize: 20,),
              CText("查看更多",icon: Icons.keyboard_arrow_right,),
            ],
          ),
          CText("附近吃喝玩乐搭配购更优惠！",padding: EdgeInsets.only(top: 5,),),
          getRecommendWidget("images/discount_5.png", "【经典单人餐Y8】+网红黑糖波霸3选1，包间免费", 11.37, "205m",false),
          SizedBox(height: 5,),
          getRecommendWidget("images/discount_6.png", "【经典单人餐Y8】+西米露奶茶1份", 11.37, "173m",true),
        ],
      ),
    );
  }

  Widget getRecommendWidget(String imgAsset,String title,double savePrice,String distance,bool minDistance){
    return CContainer(
      padding: EdgeInsets.only(top: 10,),
      direction: Direction.row,
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            CImage(width:80,heiget:60,borderRadius: 5,asset: imgAsset,),
            !minDistance ? SizedBox():
            CContainer(
              leftBottomBorderRadius: 0,
              borderRadius: 10,
              color: Colors.red,
              padding: EdgeInsets.only(left: 3,right: 3,top: 2,bottom: 2),
              child: CText("距离最近",textColor: Colors.white,textSize: 10,),
            ),
          ],
        ),
        CContainer(
          expand: true,
          height: 60,
          direction: Direction.column,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          margin: EdgeInsets.only(left: 8),
          children: <Widget>[
            CText(title,textSize: 13,maxLines: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CText("团购省¥$savePrice",textColor: Colors.red,),
                CText("距餐厅$distance",textColor: Colors.grey,),
              ],
            ),
          ],
        ),
      ],
    );
  }

}

class CommentWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 25,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CText("用户评价",textSize: 20,bold: true,),
            CText("更多评论（4314条）",textColor: CColors.primary,),
          ],
        ),
        SizedBox(height: 15,),
        ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder:(context,index) => CommentItemWidget(),
        )
      ],
    );
  }

}

class CommentItemWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CCircleAvatar("",width: 50,height: 50,),
        CContainer(
          expand: true,
          direction: Direction.column,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: EdgeInsets.only(left: 10),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CText("za3231",textSize: 14,),
                    SizedBox(height: 5,),
                    RatingBar(4.0),
                  ],
                ),
                Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    CImage(asset: "images/ic_quality_comment.png",width: 50,heiget: 50,),
                    CText("2019-6-23",textColor: Colors.grey,textSize: 13,margin: EdgeInsets.only(top: 5),),
                  ],
                ),
              ],
            ),
            CText(
              "聊城闸口肯德基用餐人数一直不多不少，等餐速度也不算慢，肯德基的小辣鸡腿堡很实惠，吃一个已经差不多八成饱了。剩下的是享受肯德基辣翅的时候了。肯德基辣翅外边包括金灿灿的油，散发着肉香。",
              maxLines: 3,
              lineHeight: 1.1,
              padding: EdgeInsets.only(top: 5,bottom: 5),
            ),
            Row(
              children: <Widget>[
                CImage(asset: "images/discount_5.png",width: 70,heiget: 70,),
                SizedBox(width: 5,),
                CImage(asset: "images/discount_6.png",width: 70,heiget: 70,),
                SizedBox(width: 5,),
                CImage(asset: "images/discount_7.png",width: 70,heiget: 70,),
              ],
            ),
            Divider(height: 20,),
          ],
        ),
      ],
    );
  }

}


class RestaurantInfoWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CText("餐厅介绍",textSize: 20,bold: true,),
            CText("193家门店适用",textColor: CColors.primary,),
          ],
        ),
        CContainer(
          direction: Direction.row,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: EdgeInsets.only(top: 10),
          children: <Widget>[
            CImage(width: 90,heiget: 90,asset: "images/discount_5.png",borderRadius: 2,),
            CContainer(
              expand: true,
              direction: Direction.column,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: EdgeInsets.only(left: 10),
              children: <Widget>[
                CText("肯德基（壹方城店）",textSize: 18,),
                SizedBox(height: 4,),
                Row(
                  children: <Widget>[
                    RatingBar(4.0),
                    CText("4.0分",textColor: CColors.orange,margin: EdgeInsets.only(left: 5),),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: CText("86m|宝安区新湖路99号西南楼2层711对面",margin: EdgeInsets.only(right: 10),),
                    ),
                    Icon(Icons.phone,color: Colors.grey,),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

}

class BottomWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return CContainer(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CText("¥5.4",textSize: 18,bold: true,textColor: CColors.orange,),
                  CContainer(
                    margin: EdgeInsets.only(left: 5),
                    padding: EdgeInsets.only(left: 5,right: 5),
                    borderRadius: 2,
                    borderWidth: 0.5,
                    borderColor: CColors.orange,
                    child: CText("9 折",textColor: CColors.orange,textSize: 11,),
                  ),
                ],
              ),
              CText("最高门市价 ¥6",textSize: 10,textColor: Colors.grey,margin: EdgeInsets.only(top: 5),)
            ],
          ),
          CContainer(
            borderRadius: 30,
            color: CColors.orange,
            padding: EdgeInsets.only(left: 30,right: 30,top: 8,bottom: 10),
            child: CText("立即抢购",bold: true,textSize: 17,textColor: Colors.white,),
          ),
        ],
      ),
    );
  }

}












