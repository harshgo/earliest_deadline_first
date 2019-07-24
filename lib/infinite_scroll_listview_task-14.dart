import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'task.dart';
import 'get_input.dart';
import 'filemanager.dart';

class InfiniteScrollListView extends StatefulWidget {
  final List<Task> ListViewData;

  InfiniteScrollListView({Key key, @required this.ListViewData})
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
        itemCount: this.widget.ListViewData.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          final item = this.widget.ListViewData[index];
          final itemText = item.name;
          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
            key: Key(item.hashCode.toString()),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) async {
              // Remove the item from the data source.
              setState(() {
                this.widget.ListViewData.removeAt(index);
              });
              final FileManager fm = FileManager();
              await fm.writeToFile(this.widget.ListViewData);

              // Show a snackbar. This snackbar could also contain "Undo" actions.
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("$itemText dismissed")));
            },
            child: Container(
              child: ListTile(title: Text('$itemText')),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
            ),
            background: Container(color: Colors.red),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      GetInput(taskList: this.widget.ListViewData)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
