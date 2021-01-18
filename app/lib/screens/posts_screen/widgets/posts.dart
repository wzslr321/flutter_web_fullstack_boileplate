import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

var _uuid = Uuid();

class Post {
  Post({
    this.title,
    this.description,
    this.author,
    String id,
  }) : id = id ?? _uuid.v4();

  final String id;
  final String title;
  final String description;
  final String author;

  @override
  String toString() {
    return 'Post(title: $title, description: $description, author: $author)';
  }
}

class PostsList extends StateNotifier<List<Post>> {
  PostsList([List<Post> initialPosts]) : super(initialPosts ?? []);

  void add(String title, String description, String author) {
    state = [
      ...state,
      Post(title: title, description: description, author: author)
    ];
  }

  void edit({@required String id, @required String description}) {
    state = [
      for (final post in state)
        if (post.id == id)
          Post(
            id: post.id,
            title: post.title,
            description: post.description,
            author: post.author,
          )
        else
          post,
    ];
  }

  void remove(Post target) {
    state = state.where((post) => post.id != target.id).toList();
  }
}
