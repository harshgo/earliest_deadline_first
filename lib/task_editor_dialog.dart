import 'package:flutter/material.dart';
import 'date_time_picker.dart';
import 'task.dart';

class TaskEditorDialog extends StatefulWidget {
  const TaskEditorDialog(this._task, this._callback) : super();
  final Task _task;
  final Function _callback;
  @override
  State<StatefulWidget> createState() => _TaskEditorDialogState(_task);
}

class _TaskEditorDialogState extends State<TaskEditorDialog> {

  _TaskEditorDialogState(this._task) : super() {
    _date = _task.dateTime;
    _time = TimeOfDay(
      hour: _task.dateTime.hour,
      minute: _task.dateTime.minute,
    );
  }

  Task _task;
  DateTime _date;
  TimeOfDay _time;

  void update() {
    widget._task.updateTime(_date, _time);
    widget._callback();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final Size screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget._task.name,
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                    ),
                    onSaved: (String value) =>
                    widget._task.name = value,
                  )),
              DateTimePicker(
                labelText: 'Choose deadline',
                selectedDate: _date,
                selectedTime: _time,
                selectDate: (DateTime date) {
                  setState(() {
                    _date = date;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    _time = time;
                  });
                },
              ),
              Container(
                width: screenSize.width,
                child: RaisedButton(
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      _formKey.currentState.save();
                      update();
                    });
                    Navigator.of(context).pop();
                  },
                  color: Colors.blue,
                ),
                margin: const EdgeInsets.only(top: 20.0),
              )
            ],
          )),
    );
  }
}
