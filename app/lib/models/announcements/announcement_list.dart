import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

import '../../models/http_exception.dart';
import '../../models/posts/post_class.dart';

import 'announcement_class.dart';

const _postApiUrl = 'http://localhost/api/announcement/announcement?all=true';

List<Announcement> parseAnnouncements(String response) {
  final el = json.decode(response) as List<dynamic>;
  final announcements = el
      .map((dynamic e) =>
  e == null ? null : Announcement.fromJson(e as Map<String, dynamic>))
      .toList();
  return announcements;
}

Future<List<Announcement>> fetchAnnouncement() async {
  final response = await http.get(_postApiUrl);
  if (response.statusCode == 200) {
    return compute(parseAnnouncements, response.body);
  }
  {
    throw HttpException("Couldn't load posts");
  }
}

class AnnouncementsList extends StateNotifier<List<Post>> {
  AnnouncementsList([List<Post> initialPosts]) :  super(initialPosts ?? []);

  void add(String title, String description, String author) {
    state = [
      ...state,
      Post(title: title, description: description, author: author)
    ];
  }

  void edit(
      {@required int id,
        @required String title,
        @required String description,
        @required String author}) {
    state = [
      for (final announcement in state)
        if (announcement.id == id)
          Post(
            id: id,
            title: title,
            description: description,
            author: author,
          )
        else
          announcement,
    ];
  }

  void remove(Post target) {
    state = state.where((post) => post.id != target.id).toList();
  }
}
