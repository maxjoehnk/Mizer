import 'package:flutter/material.dart';
import 'package:mizer/widgets/hoverable.dart';

final Color BACKGROUND = Colors.grey.shade900;
final Color ACTION_COLOR = Colors.grey.shade800;
final Color BORDER_COLOR = Colors.grey.shade700;

class ActionDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<DialogAction> actions;

  const ActionDialog({this.actions, this.title, this.content, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: BACKGROUND,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: BORDER_COLOR, width: 4)),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  color: BORDER_COLOR,
                  child: Text(title, textAlign: TextAlign.center)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: content,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions
                        .map((e) => Hoverable(
                              onTap: e.onClick,
                              builder: (hover) => Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 1),
                                  color: hover ? BORDER_COLOR : ACTION_COLOR,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(e.text)),
                            ))
                        .toList()),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DialogAction {
  final String text;
  final Function() onClick;

  const DialogAction(this.text, this.onClick);
}
