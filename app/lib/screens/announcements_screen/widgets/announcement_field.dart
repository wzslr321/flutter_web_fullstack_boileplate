import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../providers/announcements_provider.dart';


class AnnouncementField extends HookWidget {
  const AnnouncementField({
    Key key,
    @required this.controllerText,
    @required this.fieldName,
  }) : super(key: key);

  final String controllerText;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    final _announcement = useProvider(currentAnnouncement);
    final itemFocusNode = useFocusNode();

    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Focus(
      focusNode: itemFocusNode,
      onFocusChange: (focused) {
        focused
            ? textEditingController.text = controllerText
            : context.read(announcementsListNotifier).edit(
          title: fieldName == 'title'
              ? textEditingController.text
              : _announcement.title,
          author: fieldName == 'author'
              ? textEditingController.text
              : _announcement.author,
        );
      },
      child: ListTile(
        onTap: () {
          itemFocusNode.requestFocus();
          textFieldFocusNode.requestFocus();
        },
        title: isFocused
            ? TextField(
          autofocus: true,
          focusNode: textFieldFocusNode,
          controller: textEditingController,
        )
            : Text(controllerText),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('controllerText', controllerText));
    properties.add(StringProperty('fieldName', fieldName));
  }
}
