import 'package:flutter/material.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/widgets/field/text_input.dart';

class TextPropertyField extends StatefulWidget {
  final bool autofocus;
  final String label;
  final double? labelWidth;
  final bool big;
  final String value;
  final String? placeholder;
  final Function(String)? onChanged;
  final Function(String)? onUpdate;
  final bool multiline;
  final bool readOnly;
  final List<Widget> actions;

  TextPropertyField(
      {required this.label,
      this.labelWidth,
      required this.value,
      this.big = false,
      this.autofocus = false,
      this.placeholder,
      this.readOnly = false,
      this.actions = const [],
      this.onChanged,
      this.onUpdate,
      this.multiline = false});

  @override
  _TextPropertyFieldState createState() => _TextPropertyFieldState(value);
}

class _TextPropertyFieldState extends State<TextPropertyField> {
  final FocusNode focusNode = FocusNode(debugLabel: "TextPropertyField");
  final TextEditingController controller = TextEditingController();

  _TextPropertyFieldState(String value) {
    this.controller.text = value;
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      var value = controller.text;
      if (widget.value != value) {
        widget.onUpdate?.call(value);
      }
    });
  }

  @override
  void didUpdateWidget(TextPropertyField oldWidget) {
    if (oldWidget.value != widget.value && widget.value != this.controller.text) {
      this.controller.text = widget.value;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Field(
        label: this.widget.label,
        labelWidth: this.widget.labelWidth,
        big: widget.big,
        actions: widget.actions,
        vertical: widget.multiline,
        child: TextInput(
          focusNode: focusNode,
          readOnly: widget.readOnly,
          placeholder: widget.placeholder,
          controller: controller,
          onChanged: widget.onChanged,
          autofocus: widget.autofocus,
          multiline: widget.multiline,
          textInputAction: TextInputAction.next,
        ));
  }
}
