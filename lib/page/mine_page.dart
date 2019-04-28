import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/conts/text_size.dart';
import 'package:m_tuan_flutter/util/string_util.dart';
import 'package:m_tuan_flutter/widget/c_circle_avatar.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';

class MinePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }

}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{

  ScrollController controller = new ScrollController();

  double titleAlpha = 0.0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller.addListener((){
      /*跟随滑动计算标题栏背景透明度*/
      double newAlpha = controller.position.pixels / 100;
      if(newAlpha > 1) newAlpha = 1.0;
      if(titleAlpha == newAlpha) return;
      setState(() {
        titleAlpha = newAlpha;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*状态栏高度*/
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double screenWidth = MediaQuery.of(context).size.width;


    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          controller: controller,
          child: CContainer(
            color: Colors.white,
            padding: EdgeInsetsDirectional.only(start: 0,end: 0,top: 0),
            direction: Direction.column,
            children: <Widget>[
              /*顶部的原型头像及弧形背景*/
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  CContainer(
                    width: screenWidth,
                    height: 150,
                    alignment: Alignment.bottomCenter,
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color.fromARGB(255,37,217,196),
                        Color.fromARGB(255,37,217,196),
                        Color.fromARGB(255,60,183,219),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    /*圆弧背景*/
                    child: CustomPaint(size:Size(screenWidth, 40),painter: ArcPainter(),),
                  ),
                  CCircleAvatar("",width: 65,height: 65,borderWidth: 3,),
                ],
              ),
              CText("请点击登录",textSize: 18,margin: EdgeInsetsDirectional.only(top: 5),bold: true,),
              CContainer(
                padding: EdgeInsetsDirectional.only(start: 20,end: 20,top: 0),
                direction: Direction.column,
                children: <Widget>[
                  CContainer(
                    margin: EdgeInsetsDirectional.only(top: 30),
                    direction: Direction.row,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ImageWidget(name: "收藏",asset: "images/ic_mine_star.png",),
                      ImageWidget(name: "评价",asset: "images/ic_mine_appraise.png",),
                      ImageWidget(name: "最近浏览",asset: "images/ic_mine_history.png",),
                    ],
                  ),
                  Divider(height:35,color: Colors.grey[300],),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: CText("美团钱包",bold: true,textSize: 13,),
                  ),
                  GridView.count(
                    padding: EdgeInsetsDirectional.only(top: 13,bottom: 5),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 17,
                    childAspectRatio: 1.2,
                    children: <Widget>[
                      ImageWidget(name: "我的钱包",asset: "images/ic_mine_wallet.png",),
                      ImageWidget(name: "红包/卡券",asset: "images/ic_mine_red_bag.png",),
                      ImageWidget(name: "余额",asset: "images/ic_mine_balance.png",),
                      ImageWidget(name: "理财",asset: "images/ic_mine_financing.png",),
                      ImageWidget(name: "手机充值",asset: "images/ic_mine_recharge.png",),
                    ],
                  ),
                  Divider(height: 25,color: Colors.grey[300],),
                  CImage(asset: "images/banner_mine.png",),
                  Divider(height: 25,color: Colors.grey[300],),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: CText("美团服务",bold: true,textSize: 13,),
                  ),
                  GridView.count(
                    padding: EdgeInsetsDirectional.only(top: 17,bottom: 10 ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 17,
                    childAspectRatio: 1.2,
                    children: <Widget>[
                      ImageWidget(name: "新个税计算",asset: "images/ic_mine_tax.png",),
                      ImageWidget(name: "火车票/机票",asset: "images/ic_mine_train.png",),
                      ImageWidget(name: "会员中心",asset: "images/ic_mine_vip.png",),
                      ImageWidget(name: "美团公益",asset: "images/ic_mine_welfare.png",),
                      ImageWidget(name: "免流用美团",tag:"领券",asset: "images/ic_mine_flux.png",),
                      ImageWidget(name: "发票助手",asset: "images/ic_mine_bill.png",),
                      ImageWidget(name: "我要合作",asset: "images/ic_mine_cooperate.png",),
                      ImageWidget(name: "关于美团",asset: "images/ic_mine_about.png",),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        /*标题栏*/
        CContainer(
          color: Colors.transparent,
          padding: EdgeInsetsDirectional.only(start: 15,end: 15,bottom: 15,top: 15 + statusBarHeight),
          direction: Direction.row,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromARGB((255 * titleAlpha).toInt(),37,217,196),
              Color.fromARGB((255 * titleAlpha).toInt(),60,183,219),
            ],
          ),
          children: <Widget>[
            Icon(Icons.settings,color: Colors.white,),
            Row(
              children: <Widget>[
                Icon(Icons.headset_mic,color: Colors.white),
                SizedBox(width: 25,),
                Icon(Icons.mail,color: Colors.white),
              ],
            ),
          ],
        ),
      ],
    );
  }


}

///顶部的白色圆弧背景
class ArcPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    Paint patin = new Paint()..color = Colors.white..strokeWidth = 5;
    Path path = new Path()
        ..moveTo(0, size.height/2)
        ..arcToPoint(Offset(size.width,size.height/2),radius: Radius.circular(1000))
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..lineTo(0, size.height/2);
    canvas.drawPath(path, patin);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
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
    double width = (MediaQuery.of(context).size.width - 20 * 2) / 4;

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
                  margin: EdgeInsetsDirectional.only(top: 5),
                  textSize: TextSize.Normal,
                  imageScale: 2.8,
                  drawableDirection: DrawableDirection.top,
                  drawablePadding: 7.0
              ),
            ),
            CContainer(
              margin: EdgeInsetsDirectional.only(end: 10),
              color: StringUtils.isEmpty(tag) ? Colors.transparent:Colors.redAccent,
              padding: EdgeInsetsDirectional.only(start: 4,end: 4,top: 1,bottom: 1),
              borderRadius: 20,
              child: CText(tag,textSize: 10,textColor: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }

}