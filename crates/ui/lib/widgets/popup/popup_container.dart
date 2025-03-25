import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/hoverable.dart';

final Color BACKGROUND = Grey900;
final Color ACTION_COLOR = Grey800;

class PopupContainer extends StatelessWidget {
  final String title;
  final Widget? child;
  final double titleFontSize;
  final double? width;
  final double? height;
  final List<PopupAction>? actions;
  final bool padding;

  const PopupContainer(
      {required this.title,
      this.titleFontSize = 20,
      this.child,
      this.width,
      this.height,
      this.actions,
      this.padding = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: BACKGROUND,
          border: Border.all(color: Grey600, width: 2),
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 2,
              color: Colors.black26,
              offset: Offset(2, 2),
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
                child: Text(title,
                    textAlign: TextAlign.center, style: TextStyle(fontSize: titleFontSize))),
            _child,
            if (actions != null)
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Row(
                    spacing: PANEL_GAP_SIZE,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions!.map(_action).toList()),
              )
          ],
        ),
      ),
    );
  }

  Widget get _child {
    var innerChild = Container(
      child: child,
      padding: padding ? const EdgeInsets.all(8) : null,
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
          color: hover ? Grey700 : Grey800,
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
