import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/tasks_provider.dart';

import './screens/home_screen/home_screen.dart';
import './screens/page_not_found_screen/page_not_found.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => TasksProvider(),),
      ],
      child: MaterialApp(
        title: 'Flutter Forum',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.indigo,
          fontFamily: 'Roboto',
        ),
        home: HomeScreen(),
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => PageNotFoundScreen(),);
        },
      ),
    );
  }
}
