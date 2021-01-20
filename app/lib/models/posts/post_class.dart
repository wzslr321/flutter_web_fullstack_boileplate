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
