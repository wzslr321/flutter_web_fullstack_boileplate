class Post {
  Post({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.title,
    this.description,
    this.author,
  });

  Post.fromJson(Map<String, dynamic> json) {
    createdAt = json['CreatedAt'] as String;
    updatedAt = json['UpdatedAt'] as String;
    id = json['ID'] as int;
    title = json['title'] as String;
    description = json['description'] as String;
    author = json['author'] as String;
  }

  String createdAt;
  String updatedAt;
  int id;
  String title;
  String description;
  String author;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['ID'] = id;
    data['title'] = title;
    data['description'] = description;
    data['author'] = author;
    return data;
  }
}
