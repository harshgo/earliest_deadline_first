import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'task.dart';

class FileManager {
  Future<TaskSet> get populateFromFile async {
    final File file = await _localFile;
    final bool exists = file.existsSync();
    if(!exists) {
      file.create();
    }
    final String contents = await file.readAsString();
    if(contents.compareTo('') == 0) {
      return TaskSet();
    }
    final List<Object> deserialized = jsonDecode(contents);
    final TaskSet result = TaskSet();
    for (Map<String, dynamic> item in deserialized) {
      result.add(item['name'], DateTime.parse(item['time']));
    }
    return result;
  }

  Future<void> writeToFile(TaskSet data) async {
    final File file = await _localFile;
    final List<Map<String, String>> output = <Map<String, String>>[];
    for (Task task in data) {
      output.add(<String, String>{'name': task.name, 'time': task.dateTime.toString()});
    }
    final String contents = jsonEncode(output);
    await file.writeAsString(contents);
  }

  Future<String> get _localPath async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final String path = await _localPath;
    return File('$path/tasksUpdated.txt');
  }
}