import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

import 'post_class.dart';

class PostsList extends StateNotifier<List<Post>> {
  PostsList([List<Post> initialPosts]) : super(initialPosts ?? []);

  void add(String title, String description, String author) {
    state = [
      ...state,
      Post(title: title, description: description, author: author)
    ];
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
