import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/widgets/text_field_focus.dart';

import 'field.dart';

class TextPropertyField extends StatefulWidget {
  final bool autofocus;
  final String label;
  final String value;
  final String? placeholder;
  final Function(String) onUpdate;
  final bool multiline;
  final bool readOnly;
  final List<Widget> actions;

  TextPropertyField(
      {required this.label,
      required this.value,
      this.autofocus = false,
      this.placeholder,
      this.readOnly = false,
      this.actions = const [],
      required this.onUpdate,
      this.multiline = false});

  @override
  _TextPropertyFieldState createState() => _TextPropertyFieldState(value);
}

class _TextPropertyFieldState extends State<TextPropertyField> {
  final FocusNode focusNode = FocusNode(debugLabel: "TextField");
  final TextEditingController controller = TextEditingController();

  bool isEditing = false;

  _TextPropertyFieldState(String value) {
    this.controller.text = value;
  }

  @override
  void didUpdateWidget(TextPropertyField oldWidget) {
    if (oldWidget.value != widget.value && widget.value != this.controller.text) {
      this.controller.text = widget.value;
    }
    if (oldWidget.autofocus != widget.autofocus) {
      setState(() {
        this.isEditing = widget.autofocus;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    this.isEditing = widget.autofocus;
    this.focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          this.isEditing = false;
        });
      }
      this._setValue(controller.text);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this.isEditing) {
      return _editView(context);
    }

    return _readView(context);
  }

  Widget _readView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;
    TextStyle placeholderStyle = textStyle.copyWith(color: Colors.grey.shade400);
    bool hasValue = controller.text.isNotEmpty;

    var field = Field(
      label: this.widget.label,
      actions: widget.actions,
      vertical: widget.multiline,
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          hasValue ? controller.text : widget.placeholder ?? "",
          style: hasValue ? textStyle : placeholderStyle,
          textAlign: widget.multiline ? TextAlign.start : TextAlign.end,
        ),
      ),
    );

    if (widget.readOnly) {
      return field;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => this.isEditing = true),
        child: field,
      ),
    );
  }

  Widget _editView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;

    return MouseRegion(
      cursor: SystemMouseCursors.text,
      child: Field(
          label: this.widget.label,
          actions: widget.actions,
          vertical: widget.multiline,
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextFieldFocus(
              child: EditableText(
                focusNode: focusNode,
                controller: controller,
                cursorColor: Colors.black87,
                backgroundCursorColor: Colors.black12,
                style: textStyle,
                textAlign: widget.multiline ? TextAlign.start : TextAlign.end,
                selectionColor: Colors.black38,
                keyboardType: widget.multiline ? TextInputType.multiline : TextInputType.text,
                autofocus: true,
                inputFormatters: widget.multiline ? null : [FilteringTextInputFormatter.singleLineFormatter],
                maxLines: widget.multiline ? null : 1,
              ),
            ),
          )),
    );
  }

  void _setValue(String value) {
    log("_setValue $value", name: "TextField");
    if (widget.value != value) {
      widget.onUpdate(value);
    }
  }
}
