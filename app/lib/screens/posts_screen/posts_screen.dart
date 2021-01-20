import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'widgets/form.dart';

class PostsScreen extends HookWidget {
  const PostsScreen({Key key}) : super(key: key);

  static const routeName = '/posts';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: AddPostForm(addPostFormKey),
      ),
    );
  }
}
