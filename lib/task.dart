import 'package:flutter/material.dart';

class Task implements Comparable {
  String name = "";
  DateTime dateTime = DateTime.now();

  Task(this.name, this.dateTime);

  Task.fromInput(String name, DateTime date, TimeOfDay time) {
    this.name = name;
    this.dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  int compareTo(other) {
    return this.dateTime.compareTo(other.dateTime);
  }

  String getTimeLeft() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
    Duration difference = this.dateTime.difference(DateTime.now());
    bool negative = difference.isNegative;
    if (negative) {
      difference = DateTime.now().difference(this.dateTime);
    }
    String hours = twoDigits(difference.inHours);
    String mins = twoDigits(difference.inMinutes.remainder(60));
    String seconds = twoDigits(difference.inSeconds.remainder(60));
    String result = "";
    if(negative) {
      result = "-";
    }
    return result + "$hours:$mins:$seconds";
  }
}
