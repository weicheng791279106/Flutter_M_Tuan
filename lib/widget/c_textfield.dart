import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';

class CTextField extends StatelessWidget{

  String hint;
  EdgeInsets padding;
  EdgeInsets margin;
  ValueChanged<String> onChanged;
  TextAlign textAlign;
  TextInputType keyboardType;
  double textSize;
  Color textColor;
  Color hintColor;
  TextEditingController controller;
  int maxLength;

  CTextField({this.hint, this.padding, this.margin, this.onChanged,this.controller,this.maxLength,
      this.textAlign=TextAlign.left, this.keyboardType,this.textSize=14,this.textColor,this.hintColor=Colors.grey});

  @override
  Widget build(BuildContext context) {
    return CContainer(
      margin: margin,
      padding: padding,
      expand: true,
      child: TextField(
        style: TextStyle(
          fontSize: textSize,
          color: textColor,
        ),
        decoration: InputDecoration(
          counterText: "", /*不显示默认的字符输入限制提示*/
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: textSize,
            color: hintColor,
          ),
          border: InputBorder.none,
        ),
        onChanged: onChanged,
        textAlign: textAlign,
        keyboardType: keyboardType,
        controller: controller,
        maxLength: maxLength,
      ),
    );
  }

}
