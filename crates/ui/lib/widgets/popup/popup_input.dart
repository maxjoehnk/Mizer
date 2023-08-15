import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/widgets/popup/popup_container.dart';

class PopupInput extends StatefulWidget {
  final String title;
  final String? value;
  final Function(String) onChange;

  const PopupInput({required this.title, this.value, required this.onChange, Key? key})
      : super(key: key);

  @override
  State<PopupInput> createState() => _PopupInputState(value);
}

class _PopupInputState extends State<PopupInput> {
  final TextEditingController _controller;

  _PopupInputState(String? value) : _controller = TextEditingController(text: value ?? "");

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter): () => _confirm(context),
      },
      child: PopupContainer(
          title: widget.title,
          child: TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _confirm(context),
          ),
          actions: [
            PopupAction("Cancel", () => Navigator.of(context).pop()),
            PopupAction("Save", () => _confirm(context)),
          ]),
    );
  }

  void _confirm(BuildContext context) {
    widget.onChange(_controller.text);
    Navigator.of(context).pop();
  }
}
