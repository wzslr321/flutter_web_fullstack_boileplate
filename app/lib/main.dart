import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/tasks_provider.dart';

import './screens/home_screen/home_screen.dart';
import './screens/tasks_screen/tasks_screen.dart';
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
        initialRoute: '/',
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          TasksScreen.routeName:(context) => TasksScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => PageNotFoundScreen(),);
        },
      ),
    );
  }
}
