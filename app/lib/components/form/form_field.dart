import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomFormField extends HookWidget {
  const CustomFormField(
      {Key key, @required this.hintText, @required this.controller})
      : super(key: key);

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
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('hintText', hintText));
    properties.add(
        DiagnosticsProperty<TextEditingController>('controller', controller));
  }
}
