import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/announcements/announcement_list.dart';
import '../../models/posts/posts_list.dart';

import 'form_field.dart';

class CustomForm extends HookWidget {
  const CustomForm({
    @required Key key,
    @required this.hintTexts,
    @required this.controllers,
    @required this.buttonText,
    @required this.isPostsForm,
  }) : super(key: key);

  final List<String> hintTexts;
  final List<TextEditingController> controllers;
  final String buttonText;
  final bool isPostsForm;

  void clearController() {
    for (final controller in controllers) {
      controller.clear();
    }
  }

  List<String> getControllerValues() {
    final controllerValues = <String>[];
    for (final controller in controllers) {
      if (controller != null) {
        controllerValues.add(controller.text);
      }
    }
    return controllerValues;
  }



  @override
  Widget build(BuildContext context) {
    final _addPostFormKey = GlobalKey<FormState>();

    void _addValues() {
      isPostsForm == true ?
      addPostValuesToNotifier(context, getControllerValues()) :
      addAnnouncementsValuesToNotifier(context, getControllerValues());
    }

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
              addValues:  _addValues,
              buttonText: buttonText,
              clearControllers: clearController,
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
    properties.add(StringProperty('buttonText', buttonText));
    properties.add(DiagnosticsProperty<bool>('isPostsForm', isPostsForm));
  }
}

class CustomButton extends HookWidget {
  const CustomButton(
      {Key key,
      @required this.buttonText,
      @required this.addValues,
      @required this.clearControllers})
      : super(key: key);

  final String buttonText;
  final void clearControllers;
  final void addValues;



  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
        onPressed: () => {
              clearControllers,
            },
        child: Text(buttonText));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('buttonText', buttonText));
    properties.add(DiagnosticsProperty<void>('addValues', addValues));
    properties
        .add(DiagnosticsProperty<void>('clearControllers', clearControllers));
  }
}
