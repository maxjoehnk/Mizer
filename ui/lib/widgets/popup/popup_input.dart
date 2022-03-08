import 'package:flutter/material.dart';
import 'package:mizer/widgets/popup/popup_container.dart';

class PopupInput extends StatefulWidget {
  final String title;
  final String? value;
  final Function(String) onChange;

  const PopupInput({required this.title, this.value, required this.onChange, Key? key}) : super(key: key);

  @override
  State<PopupInput> createState() => _PopupInputState(value);
}

class _PopupInputState extends State<PopupInput> {
  final TextEditingController _controller;

  _PopupInputState(String? value) : _controller = TextEditingController(text: value ?? "");

  @override
  Widget build(BuildContext context) {
    return PopupContainer(title: widget.title, child: TextField(controller: _controller, autofocus: true), actions: [
      PopupAction("Cancel", () => Navigator.of(context).pop()),
      PopupAction("Save", () {
        widget.onChange(_controller.text);
        Navigator.of(context).pop();
      }),
    ]);
  }
}
