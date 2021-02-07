import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import '../models/posts/post_class.dart';
import '../models/posts/posts_list.dart';


final postsListNotifier = StateNotifierProvider((ref) {
  final posts = PostsList().fetch();
  debugPrint(posts.toString());
  for(final post in posts) {
    debugPrint(post.title);
  }
  return PostsList(PostsList().fetch());
});

final postsListProvider = Provider((ref) {
  final posts = ref.watch(postsListNotifier.state);
  for(final post in posts){
    debugPrint(post.title);
  }
  return posts;
});


final currentPost = ScopedProvider<Post>(null);



