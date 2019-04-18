import 'package:flutter/material.dart';
import 'package:m_tuan_flutter/util/string_util.dart';

class CCircleAvatar extends StatelessWidget{

  Color loadingColor;
  String url;
  double width;
  double height;

  CCircleAvatar(this.url,{this.loadingColor,this.width, this.height});

  @override
  Widget build(BuildContext context) {
    width = width ?? 45;
    height = height ?? 45;
    loadingColor = loadingColor ?? Colors.grey[100];
    url = url ?? "";

    return new SizedBox.fromSize(
        size: Size(width, height),
        child: CircleAvatar(
            backgroundColor: loadingColor,
            backgroundImage: StringUtils.isEmpty(url) ? AssetImage("images/ic_avatar_default.webp"):NetworkImage(url),
        )
    );
  }

}