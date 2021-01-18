import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter forum :D"),
      ),
      body: Container(
        child: Text("xd"),
      ),
    );
  }
}
