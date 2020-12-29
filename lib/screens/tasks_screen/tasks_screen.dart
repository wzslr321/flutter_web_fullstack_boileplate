import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/tasks_provider.dart';

class TasksScreen extends StatefulWidget {
  static const routeName = '/tasks';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<TasksProvider>(context).fetchTasks();
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tasks screen"),
        ),
        body: Container(
          child: Consumer<TasksProvider>(
            builder: (_, tasks, __) {
              return tasks.tasks == null
                  ? Text("Loading posts")
                  : Text("${tasks.tasks['title']}");
            },
          ),
        ));
  }
}
