import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'task.dart';
import 'get_input.dart';
import 'task_tile.dart';
import 'filemanager.dart';

class InfiniteScrollListView extends StatefulWidget {
  final List<Task> listViewData;

  InfiniteScrollListView({Key key, @required this.listViewData})
      : super(key: key);

  _InfiniteScrollListViewState createState() => _InfiniteScrollListViewState();
}

class _InfiniteScrollListViewState extends State<InfiniteScrollListView> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    debugPrint("dispose called");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earliest Deadline First'),
      ),
      body: ListView.builder(
        itemCount: this.widget.listViewData.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          final item = this.widget.listViewData[index];
          String itemText = item.name;
          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
              key: Key(item.hashCode.toString()),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) async {
                // Remove the item from the data source.
                setState(() {
                  this.widget.listViewData.removeAt(index);
                });
                final FileManager fm = FileManager();
                await fm.writeToFile(this.widget.listViewData);

                // Show a snackbar. This snackbar could also contain "Undo" actions.
                Scaffold.of(context)
                    .showSnackBar(
                    SnackBar(content: Text("$itemText dismissed")));
              },
              child: TaskTile(this.widget.listViewData[index]),
              background: Container(color: Colors.red),);

        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      GetInput(taskList: this.widget.listViewData)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
