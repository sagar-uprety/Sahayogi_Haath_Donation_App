import 'dart:developer';

class Timeline {
  Timeline._();
  
  static String setDate(DateTime day) {
    DateTime now = DateTime.now();
    final day2 = DateTime(day.year, day.month, day.day);
    int day1 = now.difference(day2).inDays;
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    var timeAgo = day1.toString();
    String ago;
    if (day2 == today) {
      ago = 'Today';
    } else if (day2 == yesterday) {
      ago = 'Yesterday';
    } else if (day1 >= 2 && day1 < 30) {
      ago = '$timeAgo days ago';
    } else if (day1 >= 30 && day1 <= 32) {
      ago = ' 1 month ago';
    } else {
      ago = 'Few months ago';
    }
    return (ago);
  }

}
