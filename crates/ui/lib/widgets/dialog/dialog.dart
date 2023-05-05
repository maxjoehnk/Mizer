import 'package:flutter/material.dart';
import 'package:nativeshell/nativeshell.dart';

Future<void> openDialog(BuildContext context, DialogBuilder builder) async {
  var window = await Window.create(builder.toInitData());
  return window.show();
}

abstract class DialogBuilder {
  WidgetBuilder widgetBuilder();

  dynamic toInitData();
}
