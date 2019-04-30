import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/conts/text_size.dart';
import 'package:m_tuan_flutter/util/string_util.dart';
import 'package:m_tuan_flutter/widget/c_button.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:m_tuan_flutter/widget/rating_bar.dart';
import 'package:sticky_headers/sticky_headers.dart';

class OrderPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return OrderPageState();
  }

}

class OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          CText(
            "我的订单",
            bold: true,
            textSize: 17,
            textAlign: TextAlign.center,
            padding: EdgeInsetsDirectional.only(top: 12,bottom: 12),
          ),
          Divider(height: 1,),
          Expanded(
            child: SingleChildScrollView(
              child: CContainer(
                padding: EdgeInsetsDirectional.only(start: 17,end: 17),
                margin: EdgeInsets.only(bottom: 20),
                direction: Direction.column,
                crossAxisAlignment: CrossAxisAlignment.start,
                gradient: LinearGradient(
                  colors: [
                    CColors.bgDefault,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                children: <Widget>[
                  GridView.count(
                    padding: EdgeInsetsDirectional.only(top: 13,bottom: 5),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 5,
                    mainAxisSpacing: 17,
                    childAspectRatio: 1.0,
                    children: <Widget>[
                      ImageWidget(name: "待付款",asset: "images/ic_mine_wallet.png",),
                      ImageWidget(name: "待使用",asset: "images/ic_mine_red_bag.png",),
                      ImageWidget(name: "待评价",tag:"32",asset: "images/ic_mine_balance.png",),
                      ImageWidget(name: "退款/售后",asset: "images/ic_mine_financing.png",),
                      ImageWidget(name: "全部订单",asset: "images/ic_mine_financing.png",),
                    ],
                  ),
                  CText("最近订单",textSize:16,bold: true,padding: EdgeInsetsDirectional.only(top: 12,bottom: 12)),
                  OrderWidget("美团到综","绚诺soho-{特价套餐}单人小资烫染五选一","有效期至：2020-04-09","数量：1","总价：￥148.00","待评价"),
                  OrderWidget("美团到店","喜喜量贩KTV会所","欢唱时间：2019-04-16 19:00-02:00","欢唱套餐：小房，（酒水3选1）青岛金樽高级扎啤","总价：￥88.00","待评价"),
                  Container(
                    alignment: Alignment.center,
                    child: CText("查看全部",icon: Icons.chevron_right,textSize: 14,iconSize:20,textColor: Color.fromARGB(255, 95, 105, 158),margin: EdgeInsetsDirectional.only(top: 10,bottom: 10),textAlign: TextAlign.center,),
                  ),
                  StickyHeader(
                    header: CContainer(
                      direction: Direction.column,
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width - 17 * 2,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CText("我的收藏",textSize:16,bold: true,padding: EdgeInsetsDirectional.only(top: 12,bottom: 12),),
                        Divider(height: 1,),
                      ],
                    ),
                    content: Column(
                      children: <Widget>[
                        CollectionWidget(true,"images/discount_1.png","喜喜量贩KTV会所","订",3,"人均：￥47.0","西丽","量贩式KTV"),
                        CollectionWidget(false,"images/discount_2.png","新时代宾馆","",4.5,"","银丰路","经济酒店"),
                        CollectionWidget(false,"images/discount_3.png","丰泰花园酒店热矿泉","",4,"","丰泰花园酒店","温泉"),
                        Container(
                          alignment: Alignment.center,
                          child: CText("查看全部",icon: Icons.chevron_right,textSize: 14,iconSize:20,textColor: Color.fromARGB(255, 95, 105, 158),margin: EdgeInsetsDirectional.only(top: 20,bottom: 20),textAlign: TextAlign.center,),
                        )
                      ],
                    ),
                  ),
                  StickyHeader(
                    header: CContainer(
                      direction: Direction.column,
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width - 17 * 2,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CText("最近浏览",textSize:16,bold: true,padding: EdgeInsetsDirectional.only(top: 12,bottom: 12),),
                        Divider(height: 1,),
                      ],
                    ),
                    content: Column(
                      children: <Widget>[
                        HistoryWidget(true,"images/discount_1.png","丰泰花园酒店热矿泉","33km",star: 4.0,addr: "丰泰花园酒店",type: "温泉",),
                        HistoryWidget(false,"images/discount_2.png","绚诺soho","<500m",price: "29.8",originalPrice: "门市价：￥78.0",subTitle: "单人自身造型师洗剪吹套餐",),
                        HistoryWidget(false,"images/discount_3.png","绚诺soho造型（西丽茶光店）","7.1km",star: 4.0,addr: "丰泰花园酒店",type: "温泉",),
                        Container(
                          alignment: Alignment.center,
                          child: CText("查看全部",icon: Icons.chevron_right,textSize: 14,iconSize:20,textColor: Color.fromARGB(255, 95, 105, 158),margin: EdgeInsetsDirectional.only(top: 20,bottom: 20),textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class HistoryWidget extends StatelessWidget{

  bool isTopItem;
  String imageUrl;
  String title;
  String distance;
  double star;
  String addr;
  String type;
  String subTitle;
  String price;
  String originalPrice;


  HistoryWidget(this.isTopItem,this.imageUrl, this.title, this.distance, {this.star, this.addr,
      this.type, this.subTitle, this.price, this.originalPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        isTopItem ? SizedBox(height: 15) : Divider(height: 30),
        Row(
          children: <Widget>[
            CImage(asset: imageUrl,width: 80,heiget: 65,borderRadius: 2,borderWidth: 0.3,),
            CContainer(
              expand: true,
              direction: Direction.column,
              margin: EdgeInsets.only(left: 10),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: CText(title,textSize: 16,bold: true,)),
                    CText(distance,textColor: Colors.grey,)
                  ],
                ),
                SizedBox(height: 5,),
                StringUtils.isEmpty(subTitle) ? RatingBar(star):CText(subTitle,textColor: Colors.grey,),
                SizedBox(height: 5,),
                StringUtils.isEmpty(price) ? CText(addr + "  " + type,textColor: Colors.grey[600],):priceWidget(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget priceWidget(){
    return Row(
      children: <Widget>[
        CText("￥",textColor: Colors.redAccent,textSize: 8,),
        CText(price,textColor: Colors.redAccent,textSize: 16,),
        CText(originalPrice,margin: EdgeInsets.only(left: 5),textColor: Colors.grey,)
      ],
    );
  }

}


class CollectionWidget extends StatelessWidget{

  String imageUrl;
  String title;
  String tag;
  double star;
  String price;
  String addr;
  String type;
  bool isTopItem;


  CollectionWidget(this.isTopItem,this.imageUrl, this.title, this.tag, this.star, this.price,
      this.addr, this.type,);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        isTopItem ? SizedBox(height: 15) : Divider(height: 30),
        Row(
          children: <Widget>[
            CImage(asset: imageUrl,width: 80,heiget: 60,borderRadius: 2,borderWidth: 0.3,),
            CContainer(
              direction: Direction.column,
              padding: EdgeInsets.only(left: 10),
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              expand: true,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CText(title,textSize: 16,bold: true,),
                    CContainer(
                      borderRadius: 1,
                      color: StringUtils.isEmpty(tag) ? Colors.transparent:Colors.redAccent,
                      margin: EdgeInsets.only(left: 2),
                      padding: EdgeInsets.only(left: 2,right: 2,top: 0.5,bottom: 0.5),
                      child: CText(tag,textColor: Colors.white,),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    RatingBar(star),
                    CText(price,textColor: Colors.grey[600],)
                  ],
                ),
                SizedBox(height: 5,),
                CText(addr + "  " + type,textColor: Colors.grey[600],)
              ],
            ),
          ],
        ),
      ],
    );
  }

}


class OrderWidget extends StatelessWidget{

  String type;
  String title;
  String date;
  String amount;
  String price;
  String status;


  OrderWidget(this.type, this.title, this.date, this.amount, this.price,
      this.status);

  @override
  Widget build(BuildContext context) {
    return CContainer(
      borderColor: Colors.grey[300],
      borderWidth: 0.1,
      borderRadius: 10,
      color: Colors.white,
      direction: Direction.column,
      margin: EdgeInsetsDirectional.only(bottom: 20),
      padding: EdgeInsetsDirectional.only(start: 10,end: 10,top: 15,bottom: 15),
      boxShadow: BoxShadow(offset: Offset(0,16),color:CColors.primary,blurRadius: 20,spreadRadius: -25),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CText(type,icon: Icons.access_time,drawablePadding: 5,drawableDirection: DrawableDirection.left,textSize: 14,),
            CText(status,textColor: Colors.grey,textSize: 14,margin: EdgeInsetsDirectional.only(end: 5),)
          ],
        ),
        CContainer(
          margin: EdgeInsetsDirectional.only(top: 25),
          direction: Direction.row,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CImage(asset: "images/ic_avatar_default.webp",scale: 3.0,),
            CContainer(
              expand: true,
              direction: Direction.column,
              padding: EdgeInsetsDirectional.only(start: 10),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: CText(
                          title,
                          maxLines: 1,
                          textSize: TextSize.Title,
                          bold: true,
                          margin: EdgeInsetsDirectional.only(top: 10,bottom: 10),
                        )
                    ),
                    Icon(Icons.chevron_right,color: Colors.grey,),
                  ],
                ),
                CText(date,textColor: Colors.grey[700],textSize: 14,margin: EdgeInsetsDirectional.only(top: 0),),
                CText(amount,textColor: Colors.grey[700],textSize: 14,margin: EdgeInsetsDirectional.only(top: 7),),
                CText(price,textColor: Colors.grey[700],textSize: 14,margin: EdgeInsetsDirectional.only(top: 7),),
              ],
            ),
          ],
        ),
        CContainer(
          direction: Direction.row,
          mainAxisAlignment: MainAxisAlignment.end,
          margin: EdgeInsetsDirectional.only(top: 12),
          children: <Widget>[
            SizedBox(
              width: 90,
              child: CButton(
                "评价",
                textSize: 14,
                color: Colors.transparent,
                borderWidth: 0.3,
                borderColor: Colors.grey[300],
                borderRadius: 20,
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: 90,
              child: CButton(
                "再来一单",
                textSize: 14,
                color: Colors.transparent,
                borderWidth: 0.3,
                borderColor: Colors.grey[300],
                borderRadius: 20,
              ),
            )
          ],
        ),
      ],
    );
  }

}

///带图标的Item
class ImageWidget extends StatelessWidget{

  String tag;
  String name;
  String url;
  String asset;

  ImageWidget({this.tag, this.name, this.url, this.asset});

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 17 * 2) / 5;

    return Container(
      child: SizedBox(
        width: width,
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            SizedBox(
              width: width,
              child: CText(
                  name,
                  imageAsset: asset,
                  margin: EdgeInsetsDirectional.only(top: 3),
                  textSize: TextSize.Normal,
                  imageScale: 2.6,
                  drawableDirection: DrawableDirection.top,
                  drawablePadding: 7.0
              ),
            ),
            CContainer(
              margin: EdgeInsetsDirectional.only(end: 10),
              color: StringUtils.isEmpty(tag) ? Colors.transparent:Colors.redAccent,
              padding: EdgeInsetsDirectional.only(start: 3,end: 3,top: 1,bottom: 1),
              borderRadius: 20,
              child: CText(tag,textSize: 9,textColor: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }

}