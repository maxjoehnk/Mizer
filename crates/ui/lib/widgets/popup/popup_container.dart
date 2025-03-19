import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/hoverable.dart';

final Color BACKGROUND = Grey800;
final Color ACTION_COLOR = Grey800;

class PopupContainer extends StatelessWidget {
  final String title;
  final Widget? child;
  final double? width;
  final double? height;
  final List<PopupAction>? actions;

  const PopupContainer(
      {required this.title, this.child, this.width, this.height, this.actions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: BACKGROUND,
          border: Border.all(color: Grey600, width: 2),
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
          boxShadow: [
            BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.black26
                // offset: Offset(2, 2),
                )
          ]),
      width: this.width,
      height: this.height,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                color: Grey600,
                padding: const EdgeInsets.all(8.0),
                child: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 20))),
            _child,
            if (actions != null)
              Container(
                padding: const EdgeInsets.all(8),
                child:
                    Row(mainAxisSize: MainAxisSize.min, children: actions!.map(_action).toList()),
              )
          ],
        ),
      ),
    );
  }

  Widget get _child {
    var innerChild = Container(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
    if (height != null) {
      return Expanded(child: innerChild);
    }
    return innerChild;
  }

  Widget _action(PopupAction action) {
    return Hoverable(
      onTap: action.onClick,
      builder: (hover) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          color: hover ? Grey700 : null,
          padding: const EdgeInsets.all(8),
          child: Text(action.text)),
    );
  }
}

class PopupAction {
  final String text;
  final Function() onClick;

  const PopupAction(this.text, this.onClick);
}
