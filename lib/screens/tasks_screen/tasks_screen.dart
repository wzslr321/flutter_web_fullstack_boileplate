import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  static const routeName = '/tasks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks screen"),
      ),
      body: Container(),
    );
  }
}
