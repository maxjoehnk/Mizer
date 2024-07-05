import 'package:flutter/material.dart';
import 'package:mizer/protos/ui.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class BackendDialog extends StatelessWidget {
  final ShowDialog dialogRequest;

  const BackendDialog({required this.dialogRequest, super.key});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: dialogRequest.title,
      content:
          Column(children: dialogRequest.elements.map((e) => _buildElement(context, e)).toList()),
      actions: [PopupAction("Close", () => Navigator.of(context).pop())],
    );
  }

  Widget _buildElement(BuildContext context, DialogElement element) {
    if (element.hasText()) {
      return Text(element.text);
    } else {
      print("Unsupported dialog element: $element");
      return Container();
    }
  }
}
