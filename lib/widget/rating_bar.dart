import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {

  double stars;

  RatingBar(this.stars);

  @override
  Widget build(BuildContext context) {
    List<Widget> startList = [];
    //实心星星
    var startNumber = stars ~/ 1;
    //半实心星星
    var startHalf = 0;
    if (stars.toString().contains('.')) {
      int tmp = int.parse((stars.toString().split('.')[1]));
      if (tmp >= 5) {
        startHalf = 1;
      }
    }
    //空心星星
    var startEmpty = 5 - startNumber - startHalf;

    final double startSize = 13;

    for (var i = 0; i < startNumber; i++) {
      startList.add(Icon(
        Icons.star,
        color: Colors.amberAccent,
        size: startSize,
      ));
    }
    if (startHalf > 0) {
      startList.add(Icon(
        Icons.star_half,
        color: Colors.amberAccent,
        size: startSize,
      ));
    }
    for (var i = 0; i < startEmpty; i++) {
      startList.add(Icon(
        Icons.star_border,
        color: Colors.grey,
        size: startSize,
      ));
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: startList,
      ),
    );
  }
}