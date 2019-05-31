import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/widget/c_circle_avatar.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';

class DiscoverPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return DiscoverPageState();
  }

}

class DiscoverPageState extends State<DiscoverPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CContainer(
        direction: Direction.column,
        color: CColors.bgDefault,
        children: <Widget>[
          CText("发现",textSize: 18,bold: true,padding: EdgeInsets.only(top: 12,bottom: 12),),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15,right: 15,),
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                itemCount: 30,
                itemBuilder: (context,index) => ItemWidget(index),
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              ),
            ),
          )
        ],
      ),
    );
  }

}

class ItemWidget extends StatelessWidget{

  int index;

  ItemWidget(this.index);

  @override
  Widget build(BuildContext context) {
    String imageStr = "";
    switch(index%4){

      case 0:
        imageStr = "images/travel_3.jpg";
        break;

      case 1:
        imageStr = "images/banner_1.png";
        break;

      case 2:
        imageStr = "images/discount_7.png";
        break;

      case 3:
        imageStr = "images/banner_mine.png";
        break;


    }


    return CContainer(
      color: Colors.white,
      direction: Direction.column,
      borderRadius: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CImage(asset: imageStr,leftTopRadius: 6,rightTopRadius: 6,),
        CText("小伙子被吓得不轻小伙子被吓得不轻小伙子被吓得不轻小伙子被吓得不轻",textSize:15.0,textColor:CColors.textTitle,maxLines: 2,bold: true,padding: EdgeInsets.all(10),),
        CContainer(
          direction: Direction.row,
          padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
          children: <Widget>[
            CContainer(
              direction: Direction.row,
              expand: true,
              padding: EdgeInsets.only(right: 5),
              children: <Widget>[
                CCircleAvatar("",width: 20,height: 20,),
                Expanded(child: CText("普通的美食家",padding: EdgeInsets.only(left: 5),textSize: 11.5,),),
              ],
            ),
            CText("47",icon: Icons.thumb_up,iconSize:16,drawableDirection: DrawableDirection.left,drawablePadding: 5,textColor: Colors.grey[600],),
          ],
        )
      ],
    );
  }

}