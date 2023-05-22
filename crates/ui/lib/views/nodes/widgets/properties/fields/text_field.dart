import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';

class TextPropertyField extends StatefulWidget {
  final String label;
  final String value;
  final Function(String) onUpdate;
  final bool multiline;

  TextPropertyField(
      {required this.label, required this.value, required this.onUpdate, this.multiline = false});

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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: this.isEditing ? _editView(context) : _readView(context),
    );
  }

  Widget _readView(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => this.isEditing = true),
        child: widget.multiline ? _readMultilineView(context) : _readSinglelineView(context),
      ),
    );
  }

  Widget _readSinglelineView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2!;
    return Field(
      label: this.widget.label,
      child: Text(
        controller.text,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _readMultilineView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label),
        Text(
          controller.text,
          style: textStyle,
          maxLines: 10,
          textAlign: TextAlign.start,
        )
      ],
    );
  }

  Widget _editView(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.text,
        child: widget.multiline ? _editMultilineView(context) : _editSinglelineView(context));
  }

  Widget _editSinglelineView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2!;

    return Field(
        label: this.widget.label,
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
        ));
  }

  Widget _editMultilineView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2!;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.label),
          EditableText(
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
          )
        ]);
  }

  void _setValue(String value) {
    log("_setValue $value", name: "TextField");
    if (widget.value != value) {
      widget.onUpdate(value);
    }
  }
}
