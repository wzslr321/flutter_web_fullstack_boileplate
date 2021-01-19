import 'package:riverpod/riverpod.dart';

import '../screens/posts_screen/widgets/posts.dart';

final postsProvider = StateNotifierProvider((ref) {
  return PostsList([
    Post(
        id: 'announcement-0',
        title: 'First :D',
        description: 'no siema',
        author: 'Mickiewicz'),
    Post(
        id: 'announcement-1',
        title: 'esssssssssssS',
        description: 'no i es',
        author: 'Słowacki'),
  ]);
});
