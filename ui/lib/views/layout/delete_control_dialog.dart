import 'package:flutter/material.dart';
import 'package:mizer/protos/layouts.pb.dart';

class DeleteControlDialog extends StatelessWidget {
  final LayoutControl control;

  const DeleteControlDialog({required this.control, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete Control"),
      content: SingleChildScrollView(
        child: Text("Delete Control ${control.hasLabel() ? control.label : control.node}?"),
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          autofocus: true,
          child: Text("Delete"),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
