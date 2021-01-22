class Post {
  Post({
    this.title,
    this.description,
    this.author,
    this.id,
  });

  Post.fromJson(Map<String, dynamic> json) {
    title = json['title'].toString();
    description = json['description'].toString();
    author = json['author'].toString();
    id = json['id'].toString();
  }

  String id;
  String title;
  String description;
  String author;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['author'] = author;
    data['id'] = id;
    return data;
  }
}
