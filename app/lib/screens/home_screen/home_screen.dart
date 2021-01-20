import 'package:flutter/material.dart';

import '../posts_screen/posts_screen.dart';

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
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(PostsScreen.routeName);
        },
        child: const Text('Go to posts'),
      ),
    );
  }
}
