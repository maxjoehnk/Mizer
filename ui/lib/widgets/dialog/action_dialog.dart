import 'package:flutter/material.dart';
import 'package:mizer/widgets/popup/popup_container.dart';
export 'package:mizer/widgets/popup/popup_container.dart' show PopupAction;

class ActionDialog extends StatelessWidget {
  final String title;
  final Widget? content;
  final List<PopupAction>? actions;

  const ActionDialog({this.actions, required this.title, this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: PopupContainer(
        title: title,
        child: content,
        actions: actions,
      )
    );
  }
}
