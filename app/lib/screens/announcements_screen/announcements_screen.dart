import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnnouncementsScreen extends HookWidget {
  const AnnouncementsScreen({Key key}) : super(key: key);

  static const routeName = '/announcements';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Scaffold(
        body: Text('gonna be implemented'),
      ),
    );
  }
}
