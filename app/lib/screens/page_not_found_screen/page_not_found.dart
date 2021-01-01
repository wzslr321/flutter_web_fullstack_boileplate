import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  static const routeName = '/page-not-found';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page not found"),
      ),
      body: Container(),
    );
  }
}
