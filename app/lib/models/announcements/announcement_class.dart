class Announcement {
  Announcement({this.id, this.title, this.description, this.author});

  Announcement.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    title = json['title'] as String;
    description = json['description'] as String;
    author = json['author'] as String;
  }

  String id;
  String title;
  String description;
  String author;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['author'] = author;
    return data;
  }
}
