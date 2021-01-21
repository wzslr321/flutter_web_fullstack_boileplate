import 'package:riverpod/riverpod.dart';

import '../models/posts/post_class.dart';
import '../models/posts/posts_list.dart';

final postsProvider = StateNotifierProvider((ref) {
  return PostsList([
    Post(
        id: 'announcement-0',
        title: 'Hard-coded title',
        description: 'Hard-coded description',
        author: 'Hard-coded author'),
  ]);
});

final posts = Provider((ref) {
  final posts = ref.watch(postsProvider.state);

  return posts;
});

final currentPost = ScopedProvider<Post>(null);
