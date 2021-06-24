import 'package:flutter/material.dart';
import 'package:nativeshell/nativeshell.dart';

Future<T> openDialog<T>(BuildContext context, WidgetBuilder widget) {
  if (isIntegrated(context)) {
    throw UnimplementedError();
  }
  return showDialog(context: context, builder: widget);
}

bool isIntegrated(BuildContext context) {
  return WindowState.maybeOf(context) != null;
}
