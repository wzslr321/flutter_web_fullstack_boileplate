import 'package:riverpod/riverpod.dart';
import '../models/posts/post_class.dart';
import '../models/posts/posts_list.dart';

final postsStateFuture = FutureProvider<List<Post>>((ref) async {
  return fetchPosts();
});
