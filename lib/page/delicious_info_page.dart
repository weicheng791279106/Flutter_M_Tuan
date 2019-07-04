
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/conts/load_more_status.dart';
import 'package:m_tuan_flutter/model/resp/combo_comment_resp.dart';
import 'package:m_tuan_flutter/model/resp/combo_info_resp.dart';
import 'package:m_tuan_flutter/util/http.dart';
import 'package:m_tuan_flutter/util/navigator_util.dart';
import 'package:m_tuan_flutter/util/time_util.dart';
import 'package:m_tuan_flutter/widget/c_circle_avatar.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_stateful_widget.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:m_tuan_flutter/widget/load_error_widget.dart';
import 'package:m_tuan_flutter/widget/loading_widget.dart';
import 'package:m_tuan_flutter/widget/rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';

class _Model extends Model {

  bool isLoading;
  int pageNo = 1;
  LoadMoreStatus loadMoreStatus = LoadMoreStatus.normal;

  ComboInfoResp comboInfoResp;
  ComboCommentResp comboCommentResp;

  _Model of(context) => ScopedModel.of<_Model>(context);

}

/**美食详情页*/
class DeliciousInfoPage extends CStatefulWidget{

  _Model model = _Model();

  final int PAGE_SIZE = 1;

  int deliciousId;

  ScrollController scrollController = ScrollController();

  DeliciousInfoPage(this.deliciousId);

  static void startMe(BuildContext context,int deliciousId){
    NavigatorUtil.pushWithAnimation(context, DeliciousInfoPage(deliciousId));
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if(model.loadMoreStatus == LoadMoreStatus.loading || model.loadMoreStatus == LoadMoreStatus.noMoredata) return;
        model.pageNo ++;
        requestcomboComments(context);
      }
    });
    requestComboData(context);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<_Model>(
      model: model,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder:(context,innerBoxIsScrolled) => <Widget>[
              MyAppBar(),
            ],
            body: model.isLoading ? LoadingWidget():
            model.comboInfoResp == null || model.comboInfoResp.combo == null ? LoadErrorWidget(() => requestComboData(context)):
            Column(
              children: <Widget>[
                BodyWidget(),
                BottomWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /**请求套餐详情*/
  void requestComboData(BuildContext context) async {
    model.isLoading = true;
    refresh();
    Http.post(context, "combo/getComboInfoByDeliciousId",
        FormData.from({
          "deliciousId":deliciousId,
        }),
        onSuccess: (data) {
          model.comboInfoResp = ComboInfoResp(data);
          requestcomboComments(context);
        },
        onAfter: (){
          model.isLoading = false;
          refresh();
        }
    );
  }

  /**请求评论*/
  void requestcomboComments(BuildContext context) async{
    model.loadMoreStatus = LoadMoreStatus.loading;
    Http.post(context, "combo/getComboCommentList",
        FormData.from({
          "comboId":model.comboInfoResp.combo.id,
          "pageNo":model.pageNo,
          "pageSize":PAGE_SIZE,
        }),
        onSuccess: (data) {
          ComboCommentResp response = ComboCommentResp(data);
          if(model.pageNo == 1) model.comboCommentResp = response;
          else model.comboCommentResp.commentList.addAll(response.commentList);
          if(response.commentList.length < PAGE_SIZE) model.loadMoreStatus = LoadMoreStatus.noMoredata;
          else model.loadMoreStatus = LoadMoreStatus.normal;
        },
        onError: (error) => model.loadMoreStatus = LoadMoreStatus.normal,
        onAfter: () => refresh()
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
    ComboInfoResp model = _Model().of(context).comboInfoResp;
    return CContainer(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Direction.column,
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 15),
      children: <Widget>[
        CText(model.combo.delicious.title,icon: Icons.keyboard_arrow_right,),
        CText(model.combo.comboName,textSize: 22,bold: true,),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CText("随时退 | 免预约 | 过期退",textColor: Colors.grey,),
            CText("半年销量 8.5W+",textColor: Colors.grey,),
          ],
        ),
        SizedBox(height: 10,),
        CImage(url:model.combo.imageUrl,width: double.maxFinite,),
        SizedBox(height: 10,),
        CText(model.combo.comboSimpleName,textSize: 14,),
        SizedBox(height: 5,),
        ListView.builder(
          itemCount: model.combo.foodList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder:(context,index) => FoodWidget(
            model.combo.foodList[index].name,
            model.combo.foodList[index].count,
            model.combo.foodList[index].price,
            model.combo.foodList[index].recommend,
          ),
        ),
        SizedBox(height: 20,),
        CText("温馨提示",bold: true,textSize: 20,),
        SizedBox(height: 10,),
        CText(model.combo.tips, textSize: 14, lineHeight: 1.7,),
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
    _Model model = _Model().of(context);
    if(model == null) return SizedBox();
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
          itemCount: model.comboCommentResp.commentList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder:(context,index) => CommentItemWidget(model.comboCommentResp.commentList[index]),
        ),
        CText(
          model.loadMoreStatus == LoadMoreStatus.loading ? "加载中...":model.loadMoreStatus == LoadMoreStatus.noMoredata ? "我是有底线的~":"",
          textColor: Colors.grey,
        )
      ],
    );
  }

}

class CommentItemWidget extends StatelessWidget{

  Comment model;

  CommentItemWidget(this.model,);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CCircleAvatar(model.createUser.avatarUrl,width: 50,height: 50,),
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
                    CText(model.createUser.name,textSize: 14,),
                    SizedBox(height: 5,),
                    RatingBar(model.star),
                  ],
                ),
                Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    model.quality ? CImage(asset: "images/ic_quality_comment.png",width: 50,heiget: 50,):SizedBox(),
                    CText(TimeUtil.getSocialDate(model.createDate),textColor: Colors.grey,textSize: 13,margin: EdgeInsets.only(top: 5),),
                  ],
                ),
              ],
            ),
            CText(
              model.content,
              maxLines: 3,
              lineHeight: 1.1,
              padding: EdgeInsets.only(top: 5,bottom: 5),
            ),
            Row(
              children: getImageWidgets(),
            ),
            Divider(height: 20,),
          ],
        ),
      ],
    );
  }

  /**获取评论图片Widget*/
  List<Widget> getImageWidgets(){
    List<Widget> imageWidgetList = [];
    model.imageList.forEach((url){
      imageWidgetList.add(CImage(url: url,width: 70,heiget: 70,));
      imageWidgetList.add(SizedBox(width: 5,));
    });
    return imageWidgetList;
  }

}


class RestaurantInfoWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    ComboInfoResp model = _Model().of(context).comboInfoResp;
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
            CImage(width: 90,heiget: 90,url: model.combo.delicious.imageUrl,borderRadius: 2,),
            CContainer(
              expand: true,
              direction: Direction.column,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: EdgeInsets.only(left: 10),
              children: <Widget>[
                CText(model.combo.delicious.title,textSize: 18,maxLines: 1,),
                SizedBox(height: 4,),
                Row(
                  children: <Widget>[
                    RatingBar(model.combo.delicious.star),
                    CText("${model.combo.delicious.star}分",textColor: CColors.orange,margin: EdgeInsets.only(left: 5),),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: CText("${model.combo.delicious.distance}|${model.combo.delicious.local}",margin: EdgeInsets.only(right: 10),),
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
    _Model model = _Model().of(context);
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
                  CText("¥${model.comboInfoResp.combo.price}",textSize: 18,bold: true,textColor: CColors.orange,),
                  CContainer(
                    margin: EdgeInsets.only(left: 5),
                    padding: EdgeInsets.only(left: 5,right: 5),
                    borderRadius: 2,
                    borderWidth: 0.5,
                    borderColor: CColors.orange,
                    child: CText(model.comboInfoResp.combo.discount,textColor: CColors.orange,textSize: 11,),
                  ),
                ],
              ),
              CText("最高门市价 ¥${model.comboInfoResp.combo.originalPrice}",textSize: 10,textColor: Colors.grey,margin: EdgeInsets.only(top: 5),)
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












