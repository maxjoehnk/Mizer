import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/widgets/text_field_focus.dart';

import 'field.dart';

class TextPropertyField extends StatefulWidget {
  final bool autofocus;
  final String label;
  final double? labelWidth;
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
  final TextEditingController controller = TextEditingController();

  _TextPropertyFieldState(String value) {
    this.controller.text = value;
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
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;
    return Field(
        label: this.widget.label,
        labelWidth: this.widget.labelWidth,
        actions: widget.actions,
        vertical: widget.multiline,
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: widget.multiline ? 8 : 0),
          child: TextFieldFocus(
            child: TextField(
              readOnly: widget.readOnly,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.placeholder,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                isDense: true
              ),
              controller: controller,
              cursorColor: Colors.black87,
              onChanged: widget.onChanged,
              style: textStyle,
              textAlign: widget.multiline ? TextAlign.start : TextAlign.end,
              keyboardType: widget.multiline ? TextInputType.multiline : TextInputType.text,
              autofocus: widget.autofocus,
              inputFormatters: widget.multiline ? null : [FilteringTextInputFormatter.singleLineFormatter],
              maxLines: widget.multiline ? null : 1,
              textInputAction: TextInputAction.next,
            ),
          ),
        ));
  }
}
