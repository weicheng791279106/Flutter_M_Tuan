import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';

/**加载错误*/
class LoadErrorWidget extends StatelessWidget{

  Function() onReload;

  LoadErrorWidget(this.onReload);

  @override
  Widget build(BuildContext context) {
    return CContainer(
      height: double.maxFinite,
      color: Colors.white,
      mainAxisAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      direction: Direction.column,
      onTap: () => onReload(),
      children: <Widget>[
        CImage(asset: "images/load_error.webp",width: 250),
        CText("抱歉，出错了~",bold: true,textSize: 18,margin: EdgeInsets.only(top: 15),),
        CText("点击屏幕以重新加载",bold: true,textSize: 16,margin: EdgeInsets.only(top: 10),textColor: Colors.grey,),
      ],
    );
  }

}