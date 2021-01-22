import 'package:flutter/material.dart';

import '../announcements_screen/announcements_screen.dart';
import '../posts_screen/posts_screen.dart';

final globalHomeScreen = UniqueKey();

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter forum :D'),
      ),
      body: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(PostsScreen.routeName),
              child: const Text('Go to posts dashboard'),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(AnnouncementsScreen.routeName),
              child: const Text('Go to announcements dashboard :D'),
            )
          ],
        ),
      ),
    );
  }
}
