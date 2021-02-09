import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

import '../../models/http_exception.dart';

import 'announcement_class.dart';

const _announcementApiUrl = 'http://localhost/api/announcement/';

List<Announcement> parseAnnouncements(String response) {
  final el = json.decode(response) as List<dynamic>;
  final announcements = el
      .map((dynamic e) =>
          e == null ? null : Announcement.fromJson(e as Map<String, dynamic>))
      .toList();
  return announcements;
}

Future<List<Announcement>> fetchAnnouncement() async {
  final response = await http.get('${_announcementApiUrl}announcement?all=true');
  if (response.statusCode == 200) {
    return compute(parseAnnouncements, response.body);
  }
  {
    throw HttpException("Couldn't load posts");
  }
}


class AnnouncementsList extends StateNotifier<List<Announcement>> {
  AnnouncementsList([List<Announcement> initialPosts]) : super(initialPosts ?? []);

  Future<List<Announcement>> fetch() async {
      final announcements = await fetchAnnouncement();
      return announcements;
  }

  Future<void> add(List<String> values) async {
    final _addAnnouncementUrl = '${_announcementApiUrl}add?title=${values[0]}&author=${values[1]}';
    try {
      await http.post(_addAnnouncementUrl);

      state = [
        ...state,
        Announcement(title: values[0], author: values[1])
      ];
    } catch(err) {
     throw HttpException('Error occurred while adding an announcement: $err');
    }

  }

  void remove(Announcement target) {
    try {
      http.delete('${_announcementApiUrl}announcement${target.title}');
    } catch(err){
      throw HttpException('Error occurred while removing an announcement');
    }
    state = state.where((announcement) => announcement.title != target.title).toList();
  }
}
