import 'package:flutter/material.dart';
import 'task.dart';
import 'task_editor_dialog.dart';

class TaskTile extends StatefulWidget {
  const TaskTile(this._task, this._callback);

  final Function _callback;

  @override
  _TaskTileState createState() => _TaskTileState(_task);

  final Task _task;
}

class _TaskTileState extends State<TaskTile>
    with SingleTickerProviderStateMixin {
  _TaskTileState(this._task) : super();

  Task _task;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(days: 10000));
    _animationController.reverse(from: 360000.0);
  }

  String get timerDisplayString {
    return widget._task.getTimeLeft();
  }

  Color get timerDisplayColor {
    final Duration difference = widget._task.dateTime.difference(DateTime.now());
    if(difference < Duration(seconds: 0)) {
      return Colors.red;
    } else if (difference < Duration(hours: 2)) {
      return Colors.amber;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return TaskEditorDialog(_task, widget._callback);
              });
        },
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, Widget child) {
              return Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                            title: Text(
                          '${widget._task.name}',
                        )),
                        flex: 8,
                      ),
                      Container(
                        child: Text(timerDisplayString,
                            style: TextStyle(color: timerDisplayColor)),
                        padding: const EdgeInsets.all(10.0),
                      ),
                    ]),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
              );
            }));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
