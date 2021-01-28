import 'package:riverpod/riverpod.dart';
import '../models/posts/post_class.dart';
import 'fetch_api.dart';

final postsStateFuture = FutureProvider<List<Post>>((ref) async {
  return fetchPosts();
});