import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:riverpod/riverpod.dart';

import '../../components/form/form.dart';
import '../../providers/announcements_provider.dart';

import 'widgets/announcement_item.dart';

final _addAnnouncementKey = UniqueKey();

class AnnouncementsScreen extends HookWidget {
  const AnnouncementsScreen({Key key}) : super(key: key);

  static const routeName = '/announcements';

  @override
  Widget build(BuildContext context) {
    final _announcements = useProvider(announcementsListNotifier.state);

    final _titleController = useTextEditingController();
    final _authorController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: <Widget>[
            CustomForm(
              key: _addAnnouncementKey,
              hintTexts: const ['title', 'author'],
              controllers: [_titleController, _authorController],
              isPostForm: false,
              buttonText: 'Add Announcement',
            ),
            if (_announcements.isNotEmpty) const Divider(height: 0),
            for (var i = 0; i < _announcements.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              Dismissible(
                  key: ValueKey(_announcements[i].title),
                  onDismissed: (_) {
                    context
                        .read(announcementsListNotifier)
                        .remove(_announcements[i]);
                  },
                  child: ProviderScope(
                    overrides: [
                      currentAnnouncement.overrideWithValue(_announcements[i]),
                    ],
                    child: const AnnouncementItem(),
                  ))
            ]
          ],
        ),
      ),
    );
  }
}
