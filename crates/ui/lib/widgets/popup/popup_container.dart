import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart';

final Color BACKGROUND = Grey900;
final Color ACTION_COLOR = Grey800;

class PopupContainer extends StatelessWidget {
  final String title;
  final Widget? child;
  final double? width;
  final double? height;
  final List<PopupAction>? actions;
  final bool padding;
  final bool closeButton;

  const PopupContainer(
      {required this.title,
      this.child,
      this.width,
      this.height,
      this.actions,
      this.padding = true,
      this.closeButton = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const border = BorderSide(color: Grey600, width: 2);
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: BACKGROUND,
          border: Border(
            left: border,
            right: border,
            bottom: border,
          ),
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
                height: PANEL_HEADER_HEIGHT,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                      child: Text(title,
                          textAlign: TextAlign.center, style: textTheme.titleMedium),
                    ),
                    Spacer(),
                    if (closeButton) PanelHeaderDivider(),
                    if (closeButton) PanelHeaderButton.icon(icon: Icons.close, onTap: () => Navigator.of(context).pop()),
                  ],
                )),
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
