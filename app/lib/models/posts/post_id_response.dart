import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../http_exception.dart';

class PostID {
  PostID({this.id});

  PostID.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
  }

  int id;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

PostID parseId(String response) {
  final resp = json.decode(response) as Map<String, dynamic>;
  final id = PostID.fromJson(resp);
  return id;
}

Future<PostID> fetchId(String url) async {
  final response = await http.post(url);
  if (response.statusCode == 200) {
    return compute(parseId, response.body);
  }
  {
    throw HttpException("Couldn't fetch post id");
  }
}
