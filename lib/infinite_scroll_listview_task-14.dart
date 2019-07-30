import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'get_input.dart';
import 'task.dart';
import 'task_tile.dart';

class InfiniteScrollListView extends StatefulWidget {
  const InfiniteScrollListView({Key key, @required this.tasks})
      : super(key: key);

  final TaskSet tasks;

  @override
  _InfiniteScrollListViewState createState() => _InfiniteScrollListViewState();
}

class _InfiniteScrollListViewState extends State<InfiniteScrollListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earliest Deadline First'),
      ),
      body: ListView.builder(
        itemCount: widget.tasks.length,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          final Task item = widget.tasks[index];
          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
            key: Key(item.hashCode.toString()),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (DismissDirection direction) async {
              // Remove the item from the data source.
              setState(() {
                widget.tasks.removeAt(index);
              });

              // Show a snackbar. This snackbar could also contain "Undo" actions.
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('${item.name} dismissed')));
            },
            child: TaskTile(widget.tasks[index], callback),
            background: Container(color: Colors.red),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<GetInput>(
                  builder: (BuildContext context) => GetInput(taskList: widget.tasks)));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void callback() {
    setState(() {
      widget.tasks.sort();
    });
  }
}
