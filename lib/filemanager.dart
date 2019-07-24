import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'task.dart';

class FileManager {
  Future<List<Task>> get populateFromFile async {
    File file = await _localFile;
    bool exists = await file.exists();
    if(!exists) {
      file.create();
    }
    String contents = await file.readAsString();
    if(contents.compareTo("") == 0) {
      return List<Task>();
    }
    List deserielized = jsonDecode(contents);
    List result = List<Task>();
    for (Map item in deserielized) {
      result.add(Task(item["name"], DateTime.parse(item["time"])));
    }
//    print("Result is");
//    print(result);
//    print("\n");
//    result = List<Task>();
//    result.add(Task("hello", DateTime(1997)));
    result.sort();
    return result;
  }

  Future<void> writeToFile(List<Task> data) async {
    File file = await _localFile;
    List<Map<String, String>> output = [];
    for (Task task in data) {
      output.add({"name": task.name, "time": task.dateTime.toString()});
    }
    String contents = jsonEncode(output);
    await file.writeAsString(contents);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tasksUpdated.txt');
  }
}