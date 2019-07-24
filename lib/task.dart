import 'package:flutter/material.dart';

class Task implements Comparable {
  String name = "";
  DateTime dateTime = DateTime.now();

  Task(this.name, this.dateTime);

  Task.fromInput(String name, DateTime date, TimeOfDay time) {
    this.name = name;
    this.dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  int compareTo(other) {
    return this.dateTime.compareTo(other.dateTime);
  }
}