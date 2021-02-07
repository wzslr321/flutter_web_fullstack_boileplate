import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/posts_provider.dart';


class CustomButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomButton(this.controllers);

  final List<TextEditingController> controllers;

  void _clearController() {
    for (final controller in controllers) {
      controller.clear();
    }
  }

  List<String> _getControllerValues() {
    final controllerValues = <String>[];
    for (final controller in controllers) {
      if(controller != null) {
        controllerValues.add(controller.text);
      }
    }
    return controllerValues;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
              context.read(postsListNotifier).add(_getControllerValues()),
              _clearController()
            },
        child: const Text('Add post'));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        IterableProperty<TextEditingController>('controllers', controllers));
  }
}
