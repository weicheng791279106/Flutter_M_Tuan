import 'package:intl/intl.dart';

class TimeUtil{

  static String getSocialDate(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('yyyy-MM-dd HH:mm');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(new DateTime.fromMillisecondsSinceEpoch(timestamp));
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = diff.inDays.toString() + '天前';
    } else {
      time = (diff.inDays / 7).floor().toString() + '星期前';
    }
    return time;
  }

}