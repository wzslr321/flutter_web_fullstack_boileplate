import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

import '../../models/http_exception.dart';
import '../../models/posts/post_class.dart';

import 'post_class.dart';


const _postApiUrl = 'http://localhost/api/post/';

List<Post> parsePosts(String response) {
  final el = json.decode(response) as List<dynamic>;
  final posts = el
      .map((dynamic e) =>
  e == null ? null : Post.fromJson(e as Map<String, dynamic>))
      .toList();
  return posts;
}

Future<List<Post>> fetchPosts() async {
  final response = await http.get(_postApiUrl);
  if (response.statusCode == 200) {
    return compute(parsePosts, response.body);
  }
  {
    throw HttpException("Couldn't load posts");
  }
}

class PostsList extends StateNotifier<List<Post>> {
  PostsList([List<Post> initialPosts]) :  super(initialPosts ?? []);

  Future<List<Post>> fetch() async {
    final posts = await fetchPosts();
    return posts;
  }

  void add(String title, String description, String author) {
    state = [
      ...state,
      Post(title: title, description: description, author: author)
    ];
  }

  void edit(
      {@required int id,
      @required String title,
      @required String description,
      @required String author}) {
    state = [
      for (final post in state)
        if (post.id == id)
          Post(
            id: id,
            title: title,
            description: description,
            author: author,
          )
        else
          post,
    ];
  }

  void remove(Post target) {
    state = state.where((post) => post.id != target.id).toList();
  }
}
