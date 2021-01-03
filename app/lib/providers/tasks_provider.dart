import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class TasksProvider with ChangeNotifier{
  dynamic _tasks;

  get tasks {
    return _tasks;
  }

  Future<void> fetchTasks() async {
    const url = 'http://localhost:8000/posts';
    try {
      final response = await http.get(url);
      _tasks = await convert.jsonDecode(response.body);
    } catch(error) {
      throw (error);
    }
    notifyListeners();
  }

}