class PostID {

  PostID({this.id});

  PostID.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
  }

  int id;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}