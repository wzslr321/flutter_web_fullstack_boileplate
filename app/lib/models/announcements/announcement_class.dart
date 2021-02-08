class Announcement{
  Announcement({this.title, this.author});

  Announcement.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    author = json['author'] as String;
  }

  String title;
  String author;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['author'] = author;
    return data;
  }
}