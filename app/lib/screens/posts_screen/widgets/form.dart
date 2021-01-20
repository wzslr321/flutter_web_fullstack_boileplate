import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../models/posts/post_item.dart';
import '../../../providers/posts_provider.dart';
import '../posts_screen.dart';

final addPostFormKey = GlobalKey<FormState>();

class AddPostForm extends HookWidget {
  const AddPostForm(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allPosts = useProvider(posts);

    return ListView(children: [
      Form(
          key: addPostFormKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _AddPostField(),
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
  @override
  Widget build(BuildContext context) {
    final _queryDataSize = MediaQuery.of(context).size;

    return Container(
      width: _queryDataSize.width * 0.5,
      child: TextFormField(
        decoration:
            const InputDecoration(hintText: 'Title of the post goes here'),
        validator: (value) {
          if (value.isEmpty) {
            return "Please, don't leave fields blank";
          }
          // ignore: avoid_print
          print('Is going to be implemented');
          return null;
        },
      ),
    );
  }
}

class _AddPostButton extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () =>
            context.read(postsProvider).add('title', 'description', 'author'),
        child: const Text('Add post'));
  }
}
