import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/widgets/popup/popup_container.dart';
export 'package:mizer/widgets/popup/popup_container.dart' show PopupAction;

class ActionDialog extends StatefulWidget {
  final String title;
  final bool padding;
  final Widget? content;
  final List<PopupAction>? actions;
  final Function()? onConfirm;

  const ActionDialog({this.actions, required this.title, this.content, this.onConfirm, this.padding = true, Key? key}) : super(key: key);

  @override
  State<ActionDialog> createState() => _ActionDialogState();
}

class _ActionDialogState extends State<ActionDialog> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: KeyboardListener(
        focusNode: _focusNode,
        autofocus: widget.onConfirm != null,
        onKeyEvent: (event) {
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            if (widget.onConfirm != null) {
              widget.onConfirm!();
            }
          }
        },
        child: PopupContainer(
          title: widget.title,
          child: widget.content,
          actions: widget.actions,
          padding: widget.padding,
        ),
      )
    );
  }
}
