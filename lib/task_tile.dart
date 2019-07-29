import 'package:flutter/material.dart';
import 'task.dart';

class TaskTile extends StatefulWidget {
  TaskTile(this._task);

  @override
  _TaskTileState createState() => _TaskTileState();

  final Task _task;
}

class _TaskTileState extends State<TaskTile>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    this._animationController =
        AnimationController(vsync: this, duration: Duration(days: 10000));
    _animationController.reverse(from: 360000.0);
  }

  String get timerDisplayString {
    return this.widget._task.getTimeLeft();
  }

  @override
  Widget build(BuildContext context) {
    String itemText = this.widget._task.name;
    return AnimatedBuilder(
        animation: this._animationController,
        builder: (_, Widget child) {
          return Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ListTile(title: Text('$itemText')),
                    flex: 8,
                  ),
                  Container(
                    child: Text(timerDisplayString),
                    padding: const EdgeInsets.all(10.0),
                  ),
                ]),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
          );
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
