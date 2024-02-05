import 'package:flutter/material.dart';

const double screenSaveArea = 300;

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
    double? left = position.dx;
    double? top = position.dy;
    double? right;
    double? bottom;
    if (MediaQuery.of(context).size.height - screenSaveArea < position.dy) {
      bottom = MediaQuery.of(context).size.height - position.dy;
      top = null;
    }
    if (MediaQuery.of(context).size.width - screenSaveArea < position.dx) {
      right = MediaQuery.of(context).size.width - position.dx;
      left = null;
    }

    return Stack(children: [
      Positioned(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        child: Material(textStyle: theme.bodyText2, child: child, color: Colors.transparent),
      )
    ]);
  }

  @override
  Duration get transitionDuration => Duration.zero;
}
