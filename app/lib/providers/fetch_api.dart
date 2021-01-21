import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:website/models/http_exception.dart';

import '../models/posts/post_class.dart';

List<Post> parsePosts(String response) {
  final el = json.decode(response) as List<dynamic>;
  final posts = el
      .map((dynamic e) =>
          e == null ? null : Post.fromJson(e as Map<String, dynamic>))
      .toList();
  return posts;
}

const _postApiUrl = 'http://localhost/api/post/';

Future<List<Post>> fetchPosts() async {
  final response =
      await http.get(_postApiUrl).timeout(const Duration(seconds: 5));
  response.statusCode == 200
      ? compute(parsePosts, response.body)
      : HttpException("Couldn't load posts");
}
