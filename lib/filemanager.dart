import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  Future<List<String>> get populateFromFile async {
    File file = await _localFile;
    bool exists = await file.exists();
    if(!exists) {
      file.create();
    }
    String contents = await file.readAsString();
    return contents.split("\n");
  }

  Future<void> writeToFile(List<String> data) async {
    File file = await _localFile;
    String contents = data.join("\n");
    await file.writeAsString(contents);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tasks.txt');
  }
}