import 'package:riverpod/riverpod.dart';

import '../screens/posts_screen/widgets/posts.dart';

final postsProvider = StateNotifierProvider((ref) {
  return PostsList([
    Post(
        id: 'announcement-0',
        title: 'FirstT',
        description: 'FirstD',
        author: 'Mickiewicz'),
    Post(
        id: 'announcement-1',
        title: 'SecondT',
        description: 'SecondD',
        author: 'Słowacki'),
  ]);
});

final posts = Provider((ref) {
  final posts = ref.watch(postsProvider.state);

  return posts;
});
