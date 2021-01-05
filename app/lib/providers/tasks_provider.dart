import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// ignore: prefer_mixin
class TasksProvider with ChangeNotifier {
  dynamic _tasks;

  dynamic get tasks {
    return _tasks;
  }

  Future<void> fetchTasks() async {
    const url = 'http://localhost:8000/posts';
    try {
      final response = await http.get(url);
      _tasks = await convert.jsonDecode(response.body);
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }
}
