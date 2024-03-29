import 'package:flutter/material.dart';
import 'filemanager.dart';
import 'infinite_scroll_listview_task-14.dart';
import 'task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.red,
        ),
        //home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: FutureBuilder<TaskSet>(
          future: FileManager().populateFromFile,
          builder: (BuildContext context, AsyncSnapshot<TaskSet> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'ERROR: ' + snapshot.error.toString(),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return InfiniteScrollListView(tasks: snapshot.data);
            } else {
              return Center(
                  child: const SizedBox(
                      child: CircularProgressIndicator(),
                      height: 200.0,
                      width: 200.0));
            }
          },
        ));
  }
}
