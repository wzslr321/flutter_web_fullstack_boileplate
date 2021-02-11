import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../models/http_exception.dart';
import '../../models/posts/post.dart';
import '../../models/posts/post_id_response.dart';

import 'post.dart';


const _postApiUrl = 'http://localhost/api/post/';

class PostsList extends StateNotifier<List<Post>> {
  PostsList([List<Post> initialPosts]) : super(initialPosts ?? []);


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

  Future<List<Post>> fetch() async {
    final posts = await fetchPosts();
    return posts;
  }

  Future<void> add(List<String> values) async {
    // I am aware of those urls ugliness, I am planning to deal with it.
    final _addPostUrl =
        '${_postApiUrl}add?title=${values[0]}&description=${values[1]}&author=${values[2]}';
    try {
      final postId = await fetchId(_addPostUrl);
      state = [
        ...state,
        Post(
            id: postId.id,
            title: values[0],
            description: values[1],
            author: values[2])
      ];
    } catch (err) {
      throw HttpException('Error occurred while adding a post: $err');
    }
  }

  void edit(
      {@required int id,
      @required String title,
      @required String description,
      @required String author}) {
    try {
      http.patch(
          '$_postApiUrl$id?title=$title&description=$description&author=$author');
    } catch (err) {
      throw HttpException('Error occurred while editing a post: $err');
    }
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
    try {
      http.delete(_postApiUrl + target.id.toString());
    } catch (err) {
      throw HttpException('Error occurred while removing a post: $err');
    }
    state = state.where((post) => post.id != target.id).toList();
  }
}
