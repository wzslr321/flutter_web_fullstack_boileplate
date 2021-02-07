import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../../providers/announcements_provider.dart';

class AnnouncementsScreen extends ConsumerWidget {
  const AnnouncementsScreen({Key key}) : super(key: key);

  static const routeName = '/announcements';

  @override
  Widget build(BuildContext context, T Function<T>(ProviderBase<Object,T> provider) watch) {
    final announcements = watch(announcementStateFuture);
    return Scaffold(
      appBar: AppBar(
        title: const Text('FGGP'),
      ),
      body: announcements.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('$error')),
          data: (value) {
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(value[index].title),
                );
              },
            );
          }),
    );
  }
}