import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../models/posts/post_item.dart';
import '../../../providers/posts_provider.dart';

final _addPostFormKey = GlobalKey<FormState>();

class AddPostForm extends HookWidget {
  const AddPostForm(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allPosts = useProvider(posts);

    return ListView(children: [
      Form(
          key: _addPostFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _AddPostField('Title goes here...'),
              const _AddPostField('Description goes here...'),
              const _AddPostField('Author goes here...'),
              _AddPostButton(),
              if (allPosts.isNotEmpty) const Divider(height: 0),
              for (var i = 0; i < allPosts.length; i++) ...[
                if (i > 0) const Divider(height: 0),
                Dismissible(
                  key: ValueKey(allPosts[i].id),
                  onDismissed: (_) {
                    context.read(postsProvider).remove(allPosts[i]);
                  },
                  child: ProviderScope(
                    overrides: [
                      currentPost.overrideWithValue(allPosts[i]),
                    ],
                    child: const PostItem(),
                  ),
                )
              ],
            ],
          )),
    ]);
  }
}

class _AddPostField extends StatelessWidget {
  const _AddPostField(this.hintText);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    final _newPostController = useTextEditingController();
    final _queryDataSize = MediaQuery.of(context).size;

    return Container(
      width: _queryDataSize.width * 0.5,
      child: TextFormField(
        controller: _newPostController,
        decoration: InputDecoration(hintText: hintText),
        validator: (value) {
          if (value.isEmpty) {
            return "Please, don't leave fields blank";
          }
          return null;
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('hintText', hintText));
  }
}

class _AddPostButton extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
              context.read(postsProvider).add('title', 'description', 'author'),
              // _newPostController.clear(),
            },
        child: const Text('Add post'));
  }
}
