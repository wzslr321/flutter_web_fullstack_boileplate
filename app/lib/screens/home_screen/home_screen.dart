import 'package:flutter/material.dart';

final globalHomeScreen = UniqueKey();

class HomeScreen extends StatelessWidget {
  const HomeScreen(Key key) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter forum :D'),
      ),
      body: const Text('xd'),
    );
  }
}
