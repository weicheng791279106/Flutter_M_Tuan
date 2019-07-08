import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:m_tuan_flutter/util/navigator_util.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_stateful_widget.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:scoped_model/scoped_model.dart';

class _Model extends Model{

  int index;
  List<String> urls;

}

class BigImagePage extends CStatefulWidget{

  _Model model;
  List<Widget> widgetList = [];

  static void startMe(BuildContext context,List<String> urls,{int initIndex = -1}){
    NavigatorUtil.push(context, BigImagePage(urls, initIndex,));
  }

  BigImagePage(List<String> urls,int initIndex){
    model = new _Model();
    model.urls = urls;
    model.index = initIndex;
    for(String url in model.urls) widgetList.add(
        GestureDetector(
          child: CImage(url: url,fit: BoxFit.fitWidth),
          onTap: () => Navigator.pop(context),
        )
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]); /*隐藏状态栏和虚拟按键*/
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]); /*显示状态栏和虚拟按键*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            /*图片*/
            BannerView(
                widgetList,
                cycleRolling: false,
                autoRolling: false,
                log: false,
                initIndex: model.index,
                indicatorBuilder: (context,widget) => SizedBox(),
                onPageChanged: (index){
                  model.index = index;
                  refresh();
                }
            ),
            /*指示器*/
            CContainer(
              width: double.maxFinite,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0x4c000000),
                  Color(0x00000000),
                ],),
              child: CText(
                "${model.index+1}/${model.urls.length}",textColor: Colors.white,
                bold: true,
                textSize: 16,
                textAlign: TextAlign.center,
                padding: EdgeInsets.only(top: 5,bottom: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }

}