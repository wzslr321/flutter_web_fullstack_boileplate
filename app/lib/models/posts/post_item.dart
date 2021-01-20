import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/posts_provider.dart';

class PostItem extends HookWidget {
  const PostItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _post = useProvider(currentPost);
    final itemFocusNode = useFocusNode();

    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    final _queryDataSize = MediaQuery.of(context).size;

    return Container(
      width: _queryDataSize.width * 0.45,
      child: Material(
          color: Colors.white,
          elevation: 6,
          child: Focus(
            focusNode: itemFocusNode,
            onFocusChange: (focused) {
              focused
                  ? textEditingController.text = _post.description
                  : context.read(postsProvider).edit(
                        id: _post.id,
                        title: _post.title,
                        description: textEditingController.text,
                        author: _post.author,
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
                  : Column(
                      children: [
                        Text('title: ${_post.title}'),
                        Text('description: ${_post.description}'),
                        Text('author: ${_post.author}'),
                      ],
                    ),
            ),
          )),
    );
  }
}
