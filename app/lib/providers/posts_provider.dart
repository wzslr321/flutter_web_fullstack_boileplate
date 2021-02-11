import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import '../models/posts/post.dart';
import '../models/posts/posts_list.dart';

final postsStateFuture = FutureProvider<List<Post>>((ref) async {
  return PostsList().fetch();
});

final postsListNotifier = StateNotifierProvider((ref) {
  final postsFuture = ref.watch(postsStateFuture);
  return postsFuture.when(
    data: (posts) {
      return PostsList(posts);
    },
    loading: () => PostsList([]),
    error: (_, __) => throw UnimplementedError(),
  );
});

final currentPost = ScopedProvider<Post>(null);
