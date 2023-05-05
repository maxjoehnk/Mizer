import 'package:flutter/material.dart';
import 'package:mizer/widgets/hoverable.dart';

final Color BACKGROUND = Colors.grey.shade900;
final Color ACTION_COLOR = Colors.grey.shade800;
final Color BORDER_COLOR = Colors.grey.shade700;

class PopupContainer extends StatelessWidget {
  final String title;
  final Widget? child;
  final double? width;
  final double? height;
  final List<PopupAction>? actions;

  const PopupContainer({required this.title, this.child, this.width, this.height, this.actions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: BACKGROUND,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: BORDER_COLOR, width: 4),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              color: Colors.black26
              // offset: Offset(2, 2),
            )
          ]
      ),
      width: this.width,
      height: this.height,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: const EdgeInsets.all(8.0),
                color: BORDER_COLOR,
                child: Text(title, textAlign: TextAlign.center)),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
            if (actions != null) Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions!.map(_action).toList()),
            )
          ],
        ),
      ),
    );
  }

  Widget _action(PopupAction action) {
    return  Hoverable(
      onTap: action.onClick,
      builder: (hover) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          color: hover ? BORDER_COLOR : ACTION_COLOR,
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
