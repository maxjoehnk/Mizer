import 'package:flutter/material.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/widgets/field/text_input.dart';

class NameDialog extends StatefulWidget {
  final String? name;

  const NameDialog({super.key, this.name});

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        width: 500,
        title: "Enter Name",
        content: Field(
          big: true,
          label: "Name",
          child: TextInput(
            autofocus: true,
            controller: controller,
            onSubmitted: (value) => Navigator.of(context).pop(value),
          ),
        ),
        actions: [
          PopupAction("Rename", () => Navigator.of(context).pop(controller.text)),
        ]);
  }
}

extension RenameDialog on BuildContext {
  Future<String?> showRenameDialog({String? name}) async {
    return await showDialog(
        context: this, builder: (context) => NameDialog(name: name));
  }
}
