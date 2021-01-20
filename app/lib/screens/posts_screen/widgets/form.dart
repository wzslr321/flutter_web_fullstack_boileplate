import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../providers/posts_provider.dart';

final addPostFormKey = GlobalKey<FormState>();

class AddPostForm extends StatefulWidget {
  const AddPostForm(Key key) : super(key: key);

  @override
  _AddPostFormState createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  @override
  Widget build(BuildContext context) {
    final _queryDataSize = MediaQuery.of(context).size;
    final _postsList = useProvider(postsProvider);

    return Form(
        key: addPostFormKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: _queryDataSize.width * 0.5,
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Title of the post goes here'),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please, don't leave fields blank";
                  }
                  // ignore: avoid_print
                  print('Is going to be implemented');
                  return null;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () => context
                    .read(postsProvider)
                    .add('title', 'description', 'author'),
                child: const Text('Add post'))
          ],
        ));
  }
}
