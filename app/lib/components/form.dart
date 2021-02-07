import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'form_button.dart';
import 'form_field.dart';

class CustomForm extends HookWidget {
  const CustomForm({
    @required Key key,
    @required this.hintTexts,
    @required this.controllers,
  }) : super(key: key);

  final List<String> hintTexts;
  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    final _addPostFormKey = GlobalKey<FormState>();

    return Form(
        key: _addPostFormKey,
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
            CustomButton(
              controllers,
            ),
          ],
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('hintTexts', hintTexts));
    properties.add(
        IterableProperty<TextEditingController>('controllers', controllers));
  }
}
