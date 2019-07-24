import 'package:flutter/material.dart';
import 'filemanager.dart';
import 'date_time_picker.dart';
import 'task.dart';

class GetInput extends StatefulWidget {
  final List<Task> taskList;

  GetInput({Key key, @required this.taskList}) : super(key: key);

  @override
  _GetInputState createState() => _GetInputState();
}

class _GetInputState extends State<GetInput> {
  final textEditingController = TextEditingController();
  final FileManager fm = FileManager();

  DateTime _date = DateTime.now();
  TimeOfDay _time = const TimeOfDay(hour: 23, minute: 59);

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Task name"),
              controller: textEditingController,
            ),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this.widget.taskList.add(Task.fromInput(textEditingController.text, this._date, this._time));
          this.widget.taskList.sort();
          fm.writeToFile(this.widget.taskList);
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
