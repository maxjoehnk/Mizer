import 'package:flutter/material.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/widgets/field/text_input.dart';
import 'package:mizer/i18n.dart';

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
        title: "Enter Name".i18n,
        content: Field(
          big: true,
          label: "Name".i18n,
          child: TextInput(
            autofocus: true,
            controller: controller,
            onSubmitted: (value) => Navigator.of(context).pop(value),
          ),
        ),
        actions: [
          PopupAction("Rename".i18n, () => Navigator.of(context).pop(controller.text)),
        ]);
  }
}

extension RenameDialog on BuildContext {
  Future<String?> showRenameDialog({String? name}) async {
    return await showDialog(
        context: this, builder: (context) => NameDialog(name: name));
  }
}
