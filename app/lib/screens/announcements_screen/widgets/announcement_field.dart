import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class AnnouncementField extends HookWidget {
  const AnnouncementField({
    Key key,
    @required this.controllerText,
    @required this.fieldName,
  }) : super(key: key);

  final String controllerText;
  final String fieldName;

  @override
  Widget build(BuildContext context) {

    return  ListTile(
        title:  Text(controllerText),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('controllerText', controllerText));
    properties.add(StringProperty('fieldName', fieldName));
  }
}
