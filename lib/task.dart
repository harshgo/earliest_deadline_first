import 'dart:collection';
import 'package:flutter/material.dart';
import 'filemanager.dart';

class TaskSet with IterableMixin<Task> {
  TaskSet() {
    tasks = <Task>[];
    fm = FileManager();
  }

  List<Task> tasks;
  FileManager fm;

  @override
  int get length => tasks.length;

  @override
  Iterator<Task> get iterator => tasks.iterator;

  void sort() {
    tasks.sort();
    fm.writeToFile(this);
  }

  Task operator [](int i) => tasks[i];

  void add(String name, DateTime date, [TimeOfDay time]) {
    final Task task = Task(name, date);
    _add(task);
  }

  void _add(Task task) {
    tasks.add(task);
    tasks.sort();
    fm.writeToFile(this);
  }

  void removeAt(int index) {
    tasks.removeAt(index);
    fm.writeToFile(this);
  }
}

class Task implements Comparable<Task> {
  Task(this.name, DateTime date, [TimeOfDay time]) {
    if (time == null) {
      dateTime = date;
    } else {
      dateTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    }
  }

  String name = '';
  DateTime dateTime = DateTime.now();

  void updateTime(DateTime date, TimeOfDay time) {
    dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  int compareTo(Task other) {
    return dateTime.compareTo(other.dateTime);
  }

  String getTimeLeft() {
    String twoDigits(int n) {
      if (n >= 10) {
        return '$n';
      }
      return '0$n';
    }

    Duration difference = dateTime.difference(DateTime.now());
    final bool negative = difference.isNegative;
    if (negative) {
      difference = DateTime.now().difference(dateTime);
    }
    final String hours = twoDigits(difference.inHours);
    final String minutes = twoDigits(difference.inMinutes.remainder(60));
    final String seconds = twoDigits(difference.inSeconds.remainder(60));
    String result = '';
    if (negative) {
      result = '-';
    }
    return result + '$hours:$minutes:$seconds';
  }
}
