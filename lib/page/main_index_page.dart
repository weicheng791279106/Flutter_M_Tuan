import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/conts/conts.dart';
import 'package:m_tuan_flutter/conts/text_size.dart';
import 'package:m_tuan_flutter/page/discover_page.dart';
import 'package:m_tuan_flutter/page/home_page.dart';
import 'package:m_tuan_flutter/page/mine_page.dart';
import 'package:m_tuan_flutter/page/order_page.dart';
import 'package:m_tuan_flutter/util/toast.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/eachtab.dart';
import 'package:m_tuan_flutter/widget/scale_text_widget.dart';

class MainIndexPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return MainIndexPageState();
  }

}

class MainIndexPageState extends State<MainIndexPage> with SingleTickerProviderStateMixin {

  TabController controller;

  /**上次点击退出时间戳*/
  int lastClickOutMils = 0;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 4, vsync: this);
    controller.addListener((){ setState(() {}); });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String tabImage1 = controller.index == 0 ? "images/ic_tab_1.png":"images/ic_tab_1_.png";
    String tabImage2 = controller.index == 1 ? "images/ic_tab_2.png":"images/ic_tab_2_.png";
    String tabImage3 = controller.index == 2 ? "images/ic_tab_3.png":"images/ic_tab_3_.png";
    String tabImage4 = controller.index == 3 ? "images/ic_tab_4.png":"images/ic_tab_4_.png";

    double imageSize = 27;
    double tabTextSize = TextSize.Normal;

    return MaterialApp(
      builder: (ctx, w) {
        /*设置字体最大缩放比*/
        return MaxScaleTextWidget(
          max: 1.0,
          child: w,
        );
      },
      theme: ThemeData(
        accentColor: Colors.grey, /*滑动到底颜色*/
      ),
      home: WillPopScope(
        onWillPop: doubleClickBack,
        child: Scaffold(
          body: new TabBarView(
              controller: controller,
              children: <Widget>[HomePage(), DiscoverPage(), OrderPage(), MinePage()]),
          bottomNavigationBar: new Material(
            color: Colors.white,
            child: TabBar(
                indicatorColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                controller: controller,
                labelColor: CColors.primary,
                unselectedLabelColor: Colors.black,
                tabs: <Widget>[
                  EachTab(text:"首页",height: 50,icon: CImage(asset: tabImage1,width: imageSize,heiget: imageSize),textStyle: new TextStyle(fontSize: tabTextSize)),
                  EachTab(text:"发现",height: 50,icon: CImage(asset: tabImage2,width: imageSize,heiget: imageSize),textStyle: new TextStyle(fontSize: tabTextSize)),
                  EachTab(text:"订单",height: 50,icon: CImage(asset: tabImage3,width: imageSize,heiget: imageSize),textStyle: new TextStyle(fontSize: tabTextSize)),
                  EachTab(text:"我的",height: 50,icon: CImage(asset: tabImage4,width: imageSize,heiget: imageSize),textStyle: new TextStyle(fontSize: tabTextSize)),
                ]),
          ),
        ),
      ),
    );
  }

  Future<bool> doubleClickBack() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastClickOutMils > 800) {
      lastClickOutMils = now;
      To.s("再按一次退出应用");
      return Future.value(false);
    }
    return Future.value(true);
  }

}




















