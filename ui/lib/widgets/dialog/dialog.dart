import 'package:flutter/material.dart';
import 'package:mizer/platform/platform.dart';
import 'package:nativeshell/nativeshell.dart';

Future<void> openDialog(BuildContext context, DialogBuilder builder) async {
  if (context.platform.isIntegrated) {
    var window = await Window.create(builder.toInitData());
    return window.show();
  } else {
    return showDialog(context: context, builder: builder.widgetBuilder());
  }
}

bool isIntegrated(BuildContext context) {
  return WindowState.maybeOf(context) != null;
}

abstract class DialogBuilder {
  WidgetBuilder widgetBuilder();

  dynamic toInitData();
}
