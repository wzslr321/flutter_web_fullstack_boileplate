import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './screens/posts_screen/widgets/posts.dart';

final addPostKey = UniqueKey();
final valueKey = UniqueKey();

final postsProvider = StateNotifierProvider((ref) {
  return PostsList([
    Post(
        id: 'announcement-0',
        title: 'FirstT',
        description: 'FirstD',
        author: 'Mickiewicz'),
    Post(
        id: 'announcement-1',
        title: 'SecondT',
        description: 'SecondD',
        author: 'Słowacki'),
  ]);
});

final posts = Provider((ref) {
  final posts = ref.watch(postsProvider.state);

  return posts;
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends HookWidget {
  const Home({Key key}) : super(key: key);

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
            const Title(),
            TextField(
              key: addPostKey,
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
                    _currentPost.overrideWithValue(_posts[i]),
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

class Title extends StatelessWidget {
  const Title({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'todos',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromARGB(38, 47, 47, 247),
        fontSize: 100,
        fontWeight: FontWeight.w100,
      ),
    );
  }
}

final _currentPost = ScopedProvider<Post>(null);

class PostItem extends HookWidget {
  const PostItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _post = useProvider(_currentPost);
    final itemFocusNode = useFocusNode();

    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
        color: Colors.white,
        elevation: 6,
        child: Focus(
          focusNode: itemFocusNode,
          onFocusChange: (focused) {
            focused
                ? textEditingController.text = _post.description
                : context.read(postsProvider).edit(
                    id: _post.id, description: textEditingController.text);
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
                : Text(_post.description),
          ),
        ));
  }
}
