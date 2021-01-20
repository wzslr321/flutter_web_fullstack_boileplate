import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/posts/post_class.dart';
import '../../models/posts/post_item.dart';
import '../../providers/posts_provider.dart';
import 'widgets/title.dart';

final _addPostKey = UniqueKey();

final currentPost = ScopedProvider<Post>(null);

class PostsScreen extends HookWidget {
  const PostsScreen({Key key}) : super(key: key);

  static const routeName = '/posts';

  @override
  Widget build(BuildContext context) {
    final _posts = useProvider(posts);
    final _newPostsController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            const PostTitle(),
            TextField(
              key: _addPostKey,
              controller: _newPostsController,
              decoration: const InputDecoration(
                labelText: 'What is on your mind?',
              ),
              onSubmitted: (value) {
                context.read(postsProvider).add(value, 'test', 'test2');
                _newPostsController.clear();
              },
            ),
            if (_posts.isNotEmpty) const Divider(height: 0),
            for (var i = 0; i < _posts.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              Dismissible(
                key: ValueKey(_posts[i].id),
                onDismissed: (_) {
                  context.read(postsProvider).remove(_posts[i]);
                },
                child: ProviderScope(
                  overrides: [
                    currentPost.overrideWithValue(_posts[i]),
                  ],
                  child: const PostItem(),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
