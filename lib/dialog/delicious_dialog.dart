import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/util/view_util.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';

final List<String> deliciousTypeList = [
  "全部美食（25362）",
  "食品保健（120）",
  "特色菜（54）",
  "福建菜（23）",
  "日本菜（156）",
  "饮品店（342）",
  "面包甜点（12）",
  "生日蛋糕（33）",
  "火锅（443）",
  "自助餐（12）",
  "小吃快餐（345）",
  "日韩料理（32）",
  "西餐（32）",
  "其他美食（600）",
];

List<String> locationList = [
  "附近",
  "推荐商圈",
  "福田区",
  "罗湖区",
  "南山区",
  "宝安区",
  "龙岗区",
  "龙华区",
  "盐田区",
  "南澳大鹏新区",
  "坪山区",
];

List subLocationList = [
  [
    "附近",
    "1千米",
    "3千米",
    "5千米",
    "10千米",
    "全城",
  ],
  [
    "华强北（258）",
    "宝安中心区（99）",
    "科技园（100）",
    "龙华（380）",
    "西乡（998）",
    "沙井（120）",
    "福永（78）",
  ],
  [
    "全部（4316）",
    "香蜜湖（99）",
    "梅林（100）",
    "上沙/下沙（380）",
    "华强南（998）",
    "八卦岭/圆岭（120）",
    "华强北（78）",
  ],
  [
    "全部（4316）",
    "香蜜湖（99）",
    "梅林（100）",
    "上沙/下沙（380）",
    "华强南（998）",
    "八卦岭/圆岭（120）",
    "华强北（78）",
  ],
  [
    "全部（4316）",
    "香蜜湖（99）",
    "梅林（100）",
    "上沙/下沙（380）",
    "华强南（998）",
    "八卦岭/圆岭（120）",
    "华强北（78）",
  ],
  [
    "全部（4316）",
    "香蜜湖（99）",
    "梅林（100）",
    "上沙/下沙（380）",
    "华强南（998）",
    "八卦岭/圆岭（120）",
    "华强北（78）",
  ],
  [
    "全部（4316）",
    "香蜜湖（99）",
    "梅林（100）",
    "上沙/下沙（380）",
    "华强南（998）",
    "八卦岭/圆岭（120）",
    "华强北（78）",
  ],
  [
    "全部（4316）",
    "香蜜湖（99）",
    "梅林（100）",
    "上沙/下沙（380）",
    "华强南（998）",
    "八卦岭/圆岭（120）",
    "华强北（78）",
  ],
  [
    "全部（4316）",
    "香蜜湖（99）",
    "梅林（100）",
    "上沙/下沙（380）",
    "华强南（998）",
    "八卦岭/圆岭（120）",
    "华强北（78）",
  ],
  [
    "全部（4316）",
    "香蜜湖（99）",
    "梅林（100）",
    "上沙/下沙（380）",
    "华强南（998）",
    "八卦岭/圆岭（120）",
    "华强北（78）",
  ],
  [
    "全部（4316）",
    "香蜜湖（99）",
    "梅林（100）",
    "上沙/下沙（380）",
    "华强南（998）",
    "八卦岭/圆岭（120）",
    "华强北（78）",
  ],
];


List<String> subwayList = [
  "7号线",
  "9号线",
  "11号线",
  "环中线",
  "罗宝线",
  "蛇口线",
  "龙华线",
  "龙岗线",
];

List subwayStationList = [
  [
    "全线（3384）",
    "太安（21）",
    "田贝（48）",
    "洪湖（36）",
    "笋岗（44）",
    "红岭北（128）",
    "八卦岭（22）",
  ],
  [
    "全线（3384）",
    "红树湾南（21）",
    "深湾（44）",
    "下沙（58）",
    "车公庙（78）",
    "香梅（124）",
  ],
  [
    "全线（3384）",
    "红树湾南（21）",
    "深湾（44）",
    "下沙（58）",
    "车公庙（78）",
    "香梅（124）",
  ],
  [
    "全线（3384）",
    "红树湾南（21）",
    "深湾（44）",
    "下沙（58）",
    "车公庙（78）",
    "香梅（124）",
  ],
  [
    "全线（3384）",
    "红树湾南（21）",
    "深湾（44）",
    "下沙（58）",
    "车公庙（78）",
    "香梅（124）",
  ],
  [
    "全线（3384）",
    "红树湾南（21）",
    "深湾（44）",
    "下沙（58）",
    "车公庙（78）",
    "香梅（124）",
  ],
  [
    "全线（3384）",
    "红树湾南（21）",
    "深湾（44）",
    "下沙（58）",
    "车公庙（78）",
    "香梅（124）",
  ],
  [
    "全线（3384）",
    "红树湾南（21）",
    "深湾（44）",
    "下沙（58）",
    "车公庙（78）",
    "香梅（124）",
  ],
];

/**排序类型列表*/
List<String> sortTypeList = [
  "智能排序",
  "离我最近",
  "好评优先",
  "销量最高",
];

/**
 * 美食分类弹窗
 * */
class DeliciousTypeDialog extends StatelessWidget{

  double paddingTop;
  int deliciousTypeIndex = 0;

  DeliciousTypeDialog(this.paddingTop);

  @override
  Widget build(BuildContext context) {
    return CContainer(
      direction: Direction.column,
      children: <Widget>[
        /*顶部距离，透明*/
        Container(height: paddingTop,color:Colors.transparent),
        /*列表*/
        CContainer(
          expand: true,
          color: Colors.white,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 0), /*有坑，默认padding top有一定距离，需要手动设置为0*/
            itemBuilder: (c,index) {
              return GestureDetector(
                child: CContainer(
                  direction: Direction.row,
                  padding: EdgeInsets.only(top: 15,bottom: 15,left: 15),
                  children: <Widget>[
                    /*类型*/
                    CText(
                      deliciousTypeList[index].substring(0,deliciousTypeList[index].indexOf("（")),
                      textSize:14,
                      textColor: index == deliciousTypeIndex ? CColors.primary:CColors.textTitle,
                    ),
                    /*数量*/
                    CText(
                      deliciousTypeList[index].substring(deliciousTypeList[index].indexOf("（")),
                      textSize:12,
                      textColor: index == deliciousTypeIndex ? CColors.primary:Colors.grey,
                    )
                  ],
                ),
                onTap: () => Navigator.pop(context),
              );
            },
            itemCount: deliciousTypeList.length,
          ),
        ),
        /*底部距离，半透明*/
        GestureDetector(
          child: Container(height: 100, color: CColors.half_transparent,),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }

}


/**
 * 美食位置弹窗，包括商圈和地铁两种分类
 * */
class DeliciousLocationDialog extends StatefulWidget{

  double paddingTop;

  String locationType = "商圈";
  /**父列表当前选中位置*/
  int parentIndex = 0;
  /**子列表当前选中位置*/
  int childIndex = 0;


  DeliciousLocationDialog(this.paddingTop);

  @override
  State<StatefulWidget> createState() {
    return DeliciousLocationDialogState();
  }

}

class DeliciousLocationDialogState extends State<DeliciousLocationDialog>{

  @override
  Widget build(BuildContext context) {
    List parentList = widget.locationType == "商圈" ? locationList:subwayList;
    List childList = widget.locationType == "商圈" ? subLocationList:subwayStationList;
    return CContainer(
      direction: Direction.column,
      children: <Widget>[
        /*顶部距离，透明*/
        Container(height: widget.paddingTop,color:Colors.transparent),
        /*列表*/
        CContainer(
          expand: true,
          color: Colors.white,
          padding: EdgeInsets.only(left: 20,top: 15,right: 20),
          direction: Direction.column,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  child: Container(width: 40,alignment: Alignment.center,child: CText("商圈",textColor: widget.locationType == "商圈" ? CColors.primary:CColors.textTitle,textSize: 15,)),
                  //onTap: () => setState(() widget.locationType = "商圈") ,
                  onTap: (){
                    setState(() {
                      widget.locationType = "商圈";
                      widget.parentIndex = 0;
                      widget.childIndex = 0;
                    });
                  },
                ),
                GestureDetector(
                  child: Container(width: 40,alignment: Alignment.center,margin: EdgeInsets.only(left: 20),child: CText("地铁",textColor: widget.locationType == "地铁" ? CColors.primary:CColors.textTitle,textSize: 15)),
                  onTap: (){
                    setState(() {
                      widget.locationType = "地铁";
                      widget.parentIndex = 0;
                      widget.childIndex = 0;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 12,),
            Container(
              margin: EdgeInsets.only(left: widget.locationType == "商圈" ? 0:60),
              child: Container(color: CColors.primary,width: 40,height: 3),
            ),
            CContainer(color: Colors.grey,height: 0.1,),
            Expanded(
              child:Row(
                children: <Widget>[
                  /*父位置列表*/
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0),
                      itemBuilder: (c,index) {
                        return GestureDetector(
                          child: CText(
                            "${parentList[index]}",
                            textColor: index == widget.parentIndex ? CColors.primary:CColors.textTitle,
                            textSize: 14,
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                          ),
                          onTap: (){
                            setState(() {
                              widget.parentIndex = index;
                              widget.childIndex = 0;
                            });
                          },
                        );
                      },
                      itemCount: parentList.length,
                    ),
                  ),
                  /*子位置列表*/
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0),
                      itemBuilder: (c,index) {
                        return GestureDetector(
                          child: CText(
                            "${childList[widget.parentIndex][index]}",
                            textColor: index == widget.childIndex ? CColors.primary:CColors.textTitle,
                            textSize: 14,
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                          ),
                          onTap: () => Navigator.pop(context),
                        );
                      },
                      itemCount: childList[widget.parentIndex].length,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        /*底部距离，半透明*/
        GestureDetector(
          child: Container(height: 100, color: CColors.half_transparent,),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }

}


/**
 * 排序选择弹窗
 * */
class SortTypeDialog extends StatelessWidget{

  double paddingTop;
  int sortTypeIndex = 0;

  SortTypeDialog(this.paddingTop);

  @override
  Widget build(BuildContext context) {
    return CContainer(
      direction: Direction.column,
      children: <Widget>[
        /*顶部距离，透明*/
        Container(height: paddingTop,color:Colors.transparent),
        /*列表*/
        CContainer(
          color: Colors.white,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 0), /*有坑，默认padding top有一定距离，需要手动设置为0*/
            itemBuilder: (c,index) {
              return GestureDetector(
                child: CText(
                  sortTypeList[index],
                  textSize:14,
                  textColor: index == sortTypeIndex ? CColors.primary:CColors.textTitle,
                  padding: EdgeInsets.all(15),
                ),
                onTap: () => Navigator.pop(context),
              );
            },
            itemCount: sortTypeList.length,
          ),
        ),
        /*底部距离，半透明*/
        Expanded(
          child: GestureDetector(
            child: Container(height: 100, color: CColors.half_transparent,),
            onTap: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

}


/**
 * 其他条件筛选弹窗
 * */
class FilterDialog extends StatefulWidget{

  double paddingTop;

  FilterDialog(this.paddingTop);

  @override
  State<StatefulWidget> createState() {
    return FilterDialogState();
  }

}

class FilterDialogState extends State<FilterDialog>{

  @override
  Widget build(BuildContext context) {
    double padding = 6;

    return Column(
      children: <Widget>[
        Container(height: widget.paddingTop,color: Colors.transparent,),
        CContainer(
          direction: Direction.column,
          color: Colors.white,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: EdgeInsets.all(15),
          children: <Widget>[
            CContainer(
              padding: EdgeInsets.only(bottom: padding),
              direction: Direction.row,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CText("只看免预约",textSize: 15,),
                CupertinoSwitch(
                  value: false,
                  onChanged:(newValue){},
                ),
              ],
            ),
            Divider(height: 0.1,),
            CContainer(
              padding: EdgeInsets.only(top:padding,bottom: padding),
              direction: Direction.row,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CText("节假日可用",textSize: 15,),
                CupertinoSwitch(
                  value: false,
                  onChanged:(newValue){},
                ),
              ],
            ),
            Divider(height: 0.1,),
            CContainer(
              padding: EdgeInsets.only(top:padding,bottom: padding),
              direction: Direction.row,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CText("只看新店",textSize: 15,),
                CupertinoSwitch(
                  value: false,
                  onChanged:(newValue){},
                ),
              ],
            ),
            Divider(height: 0.1,),
            CText("用餐人数",textColor: Colors.grey,margin: EdgeInsets.only(top: 20),),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.4,
              padding: EdgeInsets.only(top: 10,bottom: 0),
              children: <Widget>[
                CContainer(child: CText("单人餐",textSize: 14,),borderRadius: 3,borderColor: Colors.grey[400],borderWidth: 0.2,alignment: Alignment.center,),
                CContainer(child: CText("双人餐",textSize: 14,),borderRadius: 3,borderColor: Colors.grey[400],borderWidth: 0.2,alignment: Alignment.center,),
                CContainer(child: CText("3-4人餐",textSize: 14,),borderRadius: 3,borderColor: Colors.grey[400],borderWidth: 0.2,alignment: Alignment.center,),
                CContainer(child: CText("5-10人餐",textSize: 14,),borderRadius: 3,borderColor: Colors.grey[400],borderWidth: 0.2,alignment: Alignment.center,),
                CContainer(child: CText("10人以上",textSize: 14,),borderRadius: 3,borderColor: Colors.grey[400],borderWidth: 0.2,alignment: Alignment.center,),
              ],
            ),
            CText("餐厅服务",textColor: Colors.grey,margin: EdgeInsets.only(top: 20),),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.4,
              padding: EdgeInsets.only(top: 10,bottom: 10),
              children: <Widget>[
                CContainer(child: CText("买单",textSize: 14,),borderRadius: 3,borderColor: Colors.grey[400],borderWidth: 0.2,alignment: Alignment.center,),
                CContainer(child: CText("外卖送餐",textSize: 14,),borderRadius: 3,borderColor: Colors.grey[400],borderWidth: 0.2,alignment: Alignment.center,),
                CContainer(child: CText("订座",textSize: 14,),borderRadius: 3,borderColor: Colors.grey[400],borderWidth: 0.2,alignment: Alignment.center,),
                CContainer(child: CText("在线排队",textSize: 14,),borderRadius: 3,borderColor: Colors.grey[400],borderWidth: 0.2,alignment: Alignment.center,),
              ],
            ),
          ],
        ),
        Container(height: 0.1,color: Colors.grey,),
        CContainer(
          direction: Direction.row,
          color: Colors.white,
          children: <Widget>[
            Expanded(child: Container(child: CText("重置",textSize: 16,),alignment: Alignment.center,),flex: 1,),
            Container(width: 0.1,color: Colors.grey,height: 50,),
            Expanded(child: Container(child: CText("完成",textSize: 16,textColor: CColors.primary,),alignment: Alignment.center,),flex: 1,),
          ],
        ),
        Expanded(
          child: GestureDetector(
            child: Container(color: CColors.half_transparent,),
            onTap: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

}
