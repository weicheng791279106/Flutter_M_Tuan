import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/util/string_util.dart';

class CCircleAvatar extends StatelessWidget{

  Color loadingColor;
  String url;
  double width;
  double height;
  double borderWidth;
  Color borderColor;

  CCircleAvatar(this.url,{this.loadingColor,this.width, this.height,this.borderColor = Colors.white,this.borderWidth = 0});

  @override
  Widget build(BuildContext context) {
    width = width ?? 45;
    height = height ?? 45;
    loadingColor = loadingColor ?? Colors.grey[100];
    url = url ?? "";

    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(width: borderWidth,color: borderColor),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: CircleAvatar(
          backgroundColor: loadingColor,
          backgroundImage: StringUtils.isEmpty(url) ? AssetImage("images/ic_avatar_default.webp"):NetworkImage(url),
        )
    );
  }

}