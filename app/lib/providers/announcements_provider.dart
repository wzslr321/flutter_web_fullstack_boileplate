import 'package:riverpod/riverpod.dart';

import '../models/announcements/announcement_class.dart';
import '../models/announcements/announcement_list.dart';
import '../models/provider_exception.dart' as exception;

final announcementsStateFuture = FutureProvider<List<Announcement>>((
    ref) async {
  return AnnouncementsList().fetch();
});

final announcementsListNotifier = StateNotifierProvider((ref) {
  final announcementsFuture = ref.watch(announcementsStateFuture);

  return announcementsFuture.when(data: (announcements){
    return AnnouncementsList(announcements);
  },
    loading: () => AnnouncementsList([]),
    error: (err, trace) => throw exception.ProviderException('Error with state notifier provider: $err , $trace'),);
});

final currentAnnouncement = ScopedProvider<Announcement>(null);