import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/posts_provider.dart';

import 'post_field.dart';

class PostItem extends HookWidget {
  const PostItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _post = useProvider(currentPost);

    return Material(
        color: Colors.white,
        elevation: 6,
        child: Column(
          children: [
            PostField(
              controllerText: _post.title,
              fieldName: 'title',
            ),
            PostField(
              controllerText: _post.description,
              fieldName: 'description',
            ),
            PostField(
              controllerText: _post.author,
              fieldName: 'author',
            ),
          ],
        ));
  }
}
