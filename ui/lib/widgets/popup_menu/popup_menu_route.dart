import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopupMenuRoute extends PopupRoute {
  final Offset position;
  final Widget? child;

  PopupMenuRoute({required this.position, this.child});

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    var theme = Theme.of(context).textTheme;
    return Stack(children: [
      Positioned(
        top: position.dy,
        left: position.dx,
        child: Material(textStyle: theme.bodyText2, child: child),
      )
    ]);
  }

  @override
  Duration get transitionDuration => Duration.zero;
}
