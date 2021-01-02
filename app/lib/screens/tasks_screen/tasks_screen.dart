import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/tasks_provider.dart';
import '../loading_screen.dart';

class TasksScreen extends StatefulWidget {
  static const routeName = '/tasks';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TasksProvider>(context).fetchTasks().then((_) => {
            setState(() {
              _isLoading = false;
            })
          });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    TasksProvider _tasks = Provider.of<TasksProvider>(context);

    return _isLoading == true
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Tasks screen"),
            ),
            body: Container(child: Consumer<TasksProvider>(
              builder: (_, tasks, __) {
                return Text("${_tasks.tasks['title']}");
              },
            )),
          );
  }
}
