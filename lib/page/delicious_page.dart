
import 'package:banner_view/banner_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/conts/load_more_status.dart';
import 'package:m_tuan_flutter/dialog/delicious_dialog.dart';
import 'package:m_tuan_flutter/model/resp/delicious_home_resp.dart';
import 'package:m_tuan_flutter/model/resp/delicious_list_resp.dart';
import 'package:m_tuan_flutter/model/resp/home_data_resp.dart';
import 'package:m_tuan_flutter/util/http.dart';
import 'package:m_tuan_flutter/util/navigator_util.dart';
import 'package:m_tuan_flutter/util/string_util.dart';
import 'package:m_tuan_flutter/util/view_util.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:m_tuan_flutter/widget/loading_widget.dart';
import 'package:m_tuan_flutter/widget/pop_route.dart';
import 'package:m_tuan_flutter/widget/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  /**缓存Key*/
  final key_resp_data = "key_delicious_resp_data";

  int pageNo = 1;
  int pageSize = 10;

  /**加载更多状态*/
  LoadMoreStatus loadMoreStatus = LoadMoreStatus.normal;

  ScrollController scrollController = ScrollController();

  /**主数据*/
  DeliciousHomeResp deliciousHomeResp;
  /**列表数据*/
  DeliciousListResp deliciousListResp;

  /**请求主数据（列表之外的数据）*/
  void requestMainData(BuildContext context) async {
    Http.post(context, "delicious/deliciousHomeData", null,
      onSuccess: (data) async {
        DeliciousHomeResp response = DeliciousHomeResp(data);
        if (response.code != Http.SUCCESS) return ;
        /*缓存数据*/
        await SharedPreferences.getInstance()..setString(key_resp_data, data);
        /*更新UI*/
        setState(() => deliciousHomeResp = response);
      }
    );
  }

  /**请求列表数据*/
  Future requestListData(BuildContext context,int pageNo,int pageSize) async {
    await Http.post(context, "delicious/deliciousListData",
        FormData.from({
          "pageNo":pageNo,
          "pageSize":pageSize,
        }),
        onSuccess: (data){
          DeliciousListResp response = DeliciousListResp(data);
          setState(() {
            if (response.code != Http.SUCCESS){
              loadMoreStatus = LoadMoreStatus.loadError;
              return;
            }
            if(pageNo == 1){
              deliciousListResp = response;
              loadMoreStatus = LoadMoreStatus.normal;
              return;
            }
            deliciousListResp.deliciousList.addAll(response.deliciousList);
            loadMoreStatus = response.deliciousList.length < pageSize ? LoadMoreStatus.noMoredata:LoadMoreStatus.normal;
          });
        }
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if(loadMoreStatus == LoadMoreStatus.loading || loadMoreStatus == LoadMoreStatus.noMoredata) return;
        setState(() => loadMoreStatus = LoadMoreStatus.loading);
        pageNo++;
        requestListData(context, pageNo, pageSize);
      }
    });
    /**读取缓存*/
    SharedPreferences.getInstance().then((prefs) => setState(()=> deliciousHomeResp = DeliciousHomeResp(prefs.get(key_resp_data))));
    requestMainData(context);
    requestListData(context, pageNo, pageSize);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CContainer(
        color:Colors.white,
        direction: Direction.column,
        children: <Widget>[
          TitleBar(),
          deliciousHomeResp == null ?
              LoadingWidget() :
          Expanded(
            child: RefreshIndicator(
              child: SingleChildScrollView(
                controller: scrollController,
                physics: new AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    MBannerView(deliciousHomeResp.bannerList),
                    MainFuncWidget(deliciousHomeResp.mainFuncList),
                    SubFuncWidget(deliciousHomeResp.subFuncList),
                    DiscountWidget(deliciousHomeResp.discountList),
                    MyListView(deliciousListResp),
                    BottomWidget(loadMoreStatus)
                  ],
                ),
              ),
              onRefresh:(){
                requestMainData(context);
                pageNo = 1;
                return requestListData(context, pageNo, pageSize);
              },
            )
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
        GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
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

  MBannerView(this.bannerList);

  @override
  Widget build(BuildContext context) {
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
        log:false,
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
                CImage(url: url,width: 47,heiget: 47,),
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
              borderColor: StringUtils.isEmpty(tag) ? Colors.transparent:Colors.white,
              child: CText(tag,textSize: 9,textColor: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }

}


class SubFuncWidget extends StatelessWidget{

  final double imageWidth = 30;
  final double imageHeight = 20;

  List<Func> funcList;

  SubFuncWidget(this.funcList);

  @override
  Widget build(BuildContext context) {
    if(funcList == null) return null;
    List<Widget> widgetList = List();
    for(Func model in funcList) widgetList.add(getTypeWidget(model.imageUrl, model.name, model.tag,));
    return GridView.count(
      padding: EdgeInsets.only(left: 15, right: 15,top: 0),
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
            CContainer(
              direction: Direction.column,
              padding: EdgeInsets.only(top: 10),
              children: <Widget>[
                CImage(url: url,width: imageWidth,heiget: imageHeight,),
                CText(name,textSize: 12.5,textColor: CColors.textTitle,padding: EdgeInsets.only(top: 7),),
              ],
            ),
            CContainer(
              color: !StringUtils.isEmpty(tag) ? Color.fromARGB(255, 250, 110, 70):Colors.transparent,
              padding: EdgeInsetsDirectional.only(start: 3,end: 3,top: 1,bottom: 1),
              borderRadius: 20,
              leftBottomBorderRadius: 0,
              borderWidth: 0.5,
              borderColor: StringUtils.isEmpty(tag) ? Colors.transparent:Colors.white,
              child: CText(tag,textSize: 8,textColor: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}


class MyListView extends StatelessWidget{

  DeliciousListResp deliciousListResp;

  MyListView(this.deliciousListResp);

  @override
  Widget build(BuildContext context) {
    if(deliciousListResp == null || deliciousListResp.deliciousList == null) return SizedBox();
    return StickyHeader(
      header: FilterWidget(),
      content: CContainer(
        child: ListView.builder(
          itemBuilder: (c,index) => DeliciousWidget(deliciousListResp.deliciousList[index],index != 0),
          itemCount: deliciousListResp.deliciousList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

}


class DiscountWidget extends StatelessWidget{

  List<Discount> discountList;

  DiscountWidget(this.discountList);

  @override
  Widget build(BuildContext context) {
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
          borderColor: StringUtils.isEmpty(model.tag) ? Colors.transparent:Colors.white,
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

  GlobalKey widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CContainer(
      key: widgetKey,
      color: Colors.white,
      padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Direction.row,
      children: <Widget>[
        GestureDetector(
          child: CText("全部美食",textSize:13,icon: Icons.arrow_drop_down,iconSize: 17,textColor: Colors.grey[700],),
          onTap:() => deliciousTypeDialog(context,widgetKey),
        ),
        GestureDetector(
          child: CText("附近",textSize:13,icon: Icons.arrow_drop_down,iconSize: 17,textColor: Colors.grey[700],),
          onTap:() => deliciousLocationDialog(context,widgetKey),
        ),
        GestureDetector(
          child: CText("智能排序",textSize:13,icon: Icons.arrow_drop_down,iconSize: 17,textColor: Colors.grey[700],),
          onTap:() => sortTypeDialog(context,widgetKey),
        ),
        GestureDetector(
          child: CText("筛选",textSize:13,icon: Icons.arrow_drop_down,iconSize: 17,textColor: Colors.grey[700],),
          onTap:() => filterDialog(context,widgetKey),
        ),
      ],
    );
  }

  /**显示美食类型选择弹窗*/
  void deliciousTypeDialog(BuildContext context,GlobalKey widgetKey){
    Scrollable.ensureVisible(context); /*把筛选头部移动到ScrollView顶端*/
    Navigator.push(context, PopRoute(child: DeliciousTypeDialog(ViewUtil.getViewLocation(widgetKey).dy + ViewUtil.getViewSize(widgetKey).height)));
  }

  /**显示排序类型选择弹窗*/
  void sortTypeDialog(BuildContext context,GlobalKey widgetKey){
    Scrollable.ensureVisible(context); /*把筛选头部移动到ScrollView顶端*/
    Navigator.push(context, PopRoute(child: SortTypeDialog(ViewUtil.getViewLocation(widgetKey).dy + ViewUtil.getViewSize(widgetKey).height)));
  }

  /**显示美食位置选择弹窗*/
  void deliciousLocationDialog(BuildContext context,GlobalKey widgetKey){
    Scrollable.ensureVisible(context); /*把筛选头部移动到ScrollView顶端*/
    Navigator.push(context, PopRoute(child: DeliciousLocationDialog(
        ViewUtil.getViewLocation(widgetKey).dy + ViewUtil.getViewSize(widgetKey).height)));
  }

  /**筛选弹窗*/
  void filterDialog(BuildContext context,GlobalKey widgetKey){
    Scrollable.ensureVisible(context); /*把筛选头部移动到ScrollView顶端*/
    Navigator.push(context, PopRoute(child: FilterDialog(
        ViewUtil.getViewLocation(widgetKey).dy + ViewUtil.getViewSize(widgetKey).height)));
  }

}

/**美食列表Item Widget*/
class DeliciousWidget extends StatelessWidget{

  Delicious model;
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
                model.open ? SizedBox():CText("休息中",textColor:Colors.grey,textSize:10,icon: Icons.restore,drawableDirection: DrawableDirection.left,iconSize: 10,drawablePadding: 3,)
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
                    !model.deliveryable ? SizedBox():
                    CContainer(
                      borderWidth: 0.5,
                      borderColor: Color.fromARGB(255, 255, 153, 0),
                      borderRadius: 1,
                      padding: EdgeInsets.only(left: 1.5,right: 1.5),
                      child: CText("外",textSize:13,textColor: Color.fromARGB(255, 255, 153, 0),),
                    ),
                    !model.orderable ? SizedBox():
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
    if(StringUtils.isEmpty(model.tagList)) return [SizedBox()];
    List<Widget> tagWidgetList = [];
    int index = 1;
    for(String tag in model.tagStrList){
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

/**列表最底部的加载更多数据*/
class BottomWidget extends StatelessWidget{

  LoadMoreStatus loadMoreStatus;

  BottomWidget(this.loadMoreStatus);

  @override
  Widget build(BuildContext context) {
    //if(loadMoreStatus == LoadMoreStatus.normal) return SizedBox();
    if(loadMoreStatus == LoadMoreStatus.noMoredata) return CText("我是有底线的",textSize:14,textColor: Colors.grey,padding: EdgeInsets.all(10));
    if(loadMoreStatus == LoadMoreStatus.loadError) return CText("加载错误",textSize:14,textColor: Colors.grey,padding: EdgeInsets.all(10));
    return CContainer(
      padding: EdgeInsets.all(10),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      direction: Direction.row,
      children: <Widget>[
        CText("加载中 ",textColor: Colors.grey,textSize:14,),
        SizedBox.fromSize(
            size: Size(20, 20),
            child: CircularProgressIndicator(strokeWidth: 2,)
        )
      ],
    );
  }

}






































