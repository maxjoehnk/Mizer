import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/widgets/text_field_focus.dart';

import 'field.dart';

class TextPropertyField extends StatefulWidget {
  final String label;
  final String value;
  final String? placeholder;
  final Function(String) onUpdate;
  final bool multiline;
  final bool readOnly;

  TextPropertyField(
      {required this.label,
      required this.value,
      this.placeholder,
      this.readOnly = false,
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
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
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
    if (widget.readOnly) {
      return widget.multiline ? _readMultilineView(context) : _readSinglelineView(context);
    }
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => this.isEditing = true),
        child: widget.multiline ? _readMultilineView(context) : _readSinglelineView(context),
      ),
    );
  }

  Widget _readSinglelineView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;
    TextStyle placeholderStyle = textStyle.copyWith(color: Colors.grey.shade400);
    bool hasValue = controller.text.isNotEmpty;
    return Field(
      label: this.widget.label,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.grey.shade700,
        ),
        child: Text(
          hasValue ? controller.text : widget.placeholder ?? "",
          style: hasValue ? textStyle : placeholderStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _readMultilineView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;
    return Field(
      label: this.widget.label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.grey.shade700,
        ),
        child: Text(
          controller.text,
          style: textStyle,
          maxLines: 10,
          textAlign: TextAlign.start,
        ),
      )
    );
  }

  Widget _editView(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.text,
        child: widget.multiline ? _editMultilineView(context) : _editSinglelineView(context));
  }

  Widget _editSinglelineView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;

    return Field(
        label: this.widget.label,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.grey.shade700,
          ),
          child: TextFieldFocus(
            child: EditableText(
              focusNode: focusNode,
              controller: controller,
              cursorColor: Colors.black87,
              backgroundCursorColor: Colors.black12,
              style: textStyle,
              textAlign: TextAlign.center,
              selectionColor: Colors.black38,
              keyboardType: TextInputType.text,
              autofocus: true,
              inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
            ),
          ),
        ));
  }

  Widget _editMultilineView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;

    return Field(
        label: this.widget.label,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.grey.shade700,
          ),
          child: TextFieldFocus(
            child: EditableText(
              focusNode: focusNode,
              controller: controller,
              cursorColor: Colors.black87,
              backgroundCursorColor: Colors.black12,
              style: textStyle,
              textAlign: TextAlign.start,
              selectionColor: Colors.black38,
              keyboardType: TextInputType.multiline,
              autofocus: true,
              maxLines: null,
            ),
          ),
        ));
  }

  void _setValue(String value) {
    log("_setValue $value", name: "TextField");
    if (widget.value != value) {
      widget.onUpdate(value);
    }
  }
}
