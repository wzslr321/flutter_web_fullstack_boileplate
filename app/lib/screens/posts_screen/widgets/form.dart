import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../models/posts/post_item.dart';
import '../../../providers/posts_provider.dart';

class AddPostForm extends HookWidget {
  const AddPostForm(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _addPostFormKey = GlobalKey<FormState>();
    final allPosts = useProvider(posts);

    final newPostTitleController = useTextEditingController();
    final newPostDescriptionController = useTextEditingController();
    final newPostAuthorController = useTextEditingController();

    return ListView(children: [
      Form(
          key: _addPostFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _AddPostField('Title goes here...', newPostTitleController),
              _AddPostField(
                  'Description goes here...', newPostDescriptionController),
              _AddPostField('Author goes here...', newPostAuthorController),
              _AddPostButton(
                newPostTitleController,
                newPostDescriptionController,
                newPostAuthorController,
              ),
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

class _AddPostField extends HookWidget {
  const _AddPostField(this.hintText, this.controller);

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final _queryDataSize = MediaQuery.of(context).size;

    return Container(
        width: _queryDataSize.width * 0.5,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
          validator: (value) {
            if (value.isEmpty) {
              return "Please, don't leave fields blank";
            }

            return null;
          },
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('hintText', hintText));
    properties.add(
        DiagnosticsProperty<TextEditingController>('controller', controller));
  }
}

class _AddPostButton extends HookWidget {
  const _AddPostButton(
      this.controllerTitle, this.controllerDescription, this.controllerAuthor);

  final TextEditingController controllerTitle;
  final TextEditingController controllerDescription;
  final TextEditingController controllerAuthor;

  void _clearController() {
    controllerTitle.clear();
    controllerDescription.clear();
    controllerAuthor.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
              context.read(postsProvider).add(controllerTitle.text,
                  controllerDescription.text, controllerAuthor.text),
              _clearController()
            },
        child: const Text('Add post'));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'controllerTitle', controllerTitle));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'controllerDescription', controllerDescription));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'controllerAuthor', controllerAuthor));
  }
}
