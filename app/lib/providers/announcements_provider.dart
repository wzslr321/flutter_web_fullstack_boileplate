import 'package:riverpod/riverpod.dart';
import '../models/announcements/announcement_class.dart';
import '../models/announcements/announcement_list.dart';

final announcementStateFuture = FutureProvider<List<Announcement>>((ref) async {
  return fetchAnnouncement();
});
