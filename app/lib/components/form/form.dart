import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/announcements_provider.dart';
import '../../providers/posts_provider.dart';

import 'form_field.dart';

class CustomForm extends HookWidget {
  const CustomForm({
    @required Key key,
    @required this.hintTexts,
    @required this.controllers,
    @required this.isPostForm,
    @required this.buttonText,
  }) : super(key: key);

  final List<String> hintTexts;
  final List<TextEditingController> controllers;
  final bool isPostForm;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    void _clearController() {
      for (final controller in controllers) {
        controller.clear();
      }
    }

    List<String> _getControllerValues() {
      final controllerValues = <String>[];
      for (final controller in controllers) {
        if (controller != null) {
          controllerValues.add(controller.text);
        }
      }
      return controllerValues;
    }

    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (controllers.isNotEmpty) const Divider(height: 0),
            for (var i = 0; i < controllers.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              CustomFormField(
                controller: controllers[i],
                hintText: hintTexts[i],
              ),
            ],
            ElevatedButton(
                onPressed: () => {
                      if (isPostForm)
                        {
                          context
                              .read(postsListNotifier)
                              .add(_getControllerValues())
                        }
                      else
                        {
                          context
                              .read(announcementsListNotifier)
                              .add(_getControllerValues()),
                        },
                      _clearController()
                    },
                child: Text(buttonText))
          ],
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('hintTexts', hintTexts));
    properties.add(
        IterableProperty<TextEditingController>('controllers', controllers));
    properties.add(DiagnosticsProperty<bool>('isPostForm', isPostForm));
    properties.add(StringProperty('buttonText', buttonText));
  }
}
