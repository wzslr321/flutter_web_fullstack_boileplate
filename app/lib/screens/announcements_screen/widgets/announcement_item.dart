import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/announcements_provider.dart';

import 'announcement_field.dart';

class AnnouncementItem extends HookWidget {
  const AnnouncementItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _announcement = useProvider(currentAnnouncement);

    return Material(
        color: Colors.white,
        elevation: 6,
        child: Column(
          children: [
           AnnouncementField(
              controllerText: _announcement.title,
              fieldName: 'title',
            ),
            AnnouncementField(
              controllerText: _announcement.author,
              fieldName: 'author',
            ),
          ],
        ));
  }
}
