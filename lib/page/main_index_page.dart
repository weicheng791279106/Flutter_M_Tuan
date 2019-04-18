import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/conts/conts.dart';
import 'package:m_tuan_flutter/page/discover_page.dart';
import 'package:m_tuan_flutter/page/home_page.dart';
import 'package:m_tuan_flutter/page/mine_page.dart';
import 'package:m_tuan_flutter/page/order_page.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/eachtab.dart';

class MainIndexPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return MainIndexPageState();
  }

}

class MainIndexPageState extends State<MainIndexPage> with SingleTickerProviderStateMixin {

  TabController controller;

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
    double tabTextSize = 9;

    return MaterialApp(
      home: Scaffold(
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
    );
  }

}




















