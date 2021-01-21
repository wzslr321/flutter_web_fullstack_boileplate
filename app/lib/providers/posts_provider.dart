import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

import '../models/posts/post_class.dart';

final postsProvider = StateNotifierProvider((ref) {
  return PostsList();
});

final posts = Provider((ref) {
  final posts = ref.watch(postsProvider.state);

  return posts;
});

final currentPost = ScopedProvider<Post>(null);

const postApiUrl = 'http://localhost/api/post/';

class PostsList extends StateNotifier<List<Post>> {
  PostsList([List<Post> initialPosts]) : super(initialPosts ?? []);

  void add(String title, String description, String author) {
    state = [
      ...state,
      Post(title: title, description: description, author: author)
    ];
  }

  Future<void> fetch() async {
    final response = await http.get(postApiUrl);
    final loadedPosts = <Post>[];
    final extractedPosts = json.decode(response.body) as Map<String, dynamic>;
    if (extractedPosts == null) {
      return;
    }
    extractedPosts.forEach((postId, dynamic postsData) {
      loadedPosts.add(Post(
          title: postsData['title'].toString(),
          description: postsData.toString()));
    });
  }

  void edit(
      {@required String id,
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
