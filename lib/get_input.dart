import 'package:flutter/material.dart';
import 'filemanager.dart';

class GetInput extends StatefulWidget {
  final List<String> taskList;

  GetInput({Key key, @required this.taskList}): super(key: key);

  @override
  _GetInputState createState() => _GetInputState();
}

class _GetInputState extends State<GetInput> {
  final textEditingController = TextEditingController();
  final FileManager fm = FileManager();

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
        child: TextField(
          controller: textEditingController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this.widget.taskList.add(textEditingController.text);
          fm.writeToFile(this.widget.taskList);
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
