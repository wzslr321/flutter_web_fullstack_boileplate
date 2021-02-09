import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'screens/announcements_screen/announcements_screen.dart';

import 'screens/home_screen/home_screen.dart';
import 'screens/page_not_found_screen/page_not_found.dart';
import 'screens/posts_screen/posts_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FGGP Boilerplate',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.cyanAccent,
      ),
      home: const HomeScreen(),
      routes: {
        PostsScreen.routeName: (ctx) => const PostsScreen(),
        AnnouncementsScreen.routeName: (ctx) => const AnnouncementsScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute<PageNotFoundScreen>(
            builder: (ctx) => const PageNotFoundScreen());
      },
    );
  }
}
