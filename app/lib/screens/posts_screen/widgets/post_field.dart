import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/posts_provider.dart';

class PostField extends HookWidget {
  const PostField({
    Key key,
    @required this.controllerText,
    @required this.fieldName,
  }) : super(key: key);

  final String controllerText;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    final _post = useProvider(currentPost);
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
            : context.read(postsListNotifier).edit(
                  id: _post.id,
                  title: fieldName == 'title'
                      ? textEditingController.text
                      : _post.title,
                  description: fieldName == 'description'
                      ? textEditingController.text
                      : _post.description,
                  author: fieldName == 'author'
                      ? textEditingController.text
                      : _post.author,
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
