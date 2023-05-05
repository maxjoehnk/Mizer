import 'package:flutter/material.dart';

class MizerPopupRoute extends PopupRoute {
  final Offset position;
  final Widget? child;

  MizerPopupRoute({required this.position, this.child});

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
        child: Material(textStyle: theme.bodyText2, child: child, color: Colors.transparent),
      )
    ]);
  }

  @override
  Duration get transitionDuration => Duration.zero;
}
