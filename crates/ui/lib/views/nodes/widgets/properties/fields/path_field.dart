import 'dart:developer';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/widgets/text_field_focus.dart';

import 'field.dart';

class PathField extends StatefulWidget {
  final String? label;
  final String value;
  final String? placeholder;
  final List<Widget> actions;
  final Function(String) onUpdate;
  final bool readOnly;

  PathField(
      {this.label,
      required this.value,
      this.placeholder,
      this.readOnly = false,
      this.actions = const [],
      required this.onUpdate});

  @override
  _PathFieldState createState() => _PathFieldState(value);
}

class _PathFieldState extends State<PathField> {
  final FocusNode focusNode = FocusNode(debugLabel: "PathField");
  final TextEditingController controller = TextEditingController();

  bool isEditing = false;

  _PathFieldState(String value) {
    this.controller.text = value;
  }

  @override
  void didUpdateWidget(PathField oldWidget) {
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
      return _readSinglelineView(context);
    }
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => this.isEditing = true),
        child: _readSinglelineView(context),
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
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          hasValue ? controller.text : widget.placeholder ?? "",
          style: hasValue ? textStyle : placeholderStyle,
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        FieldAction(
          onTap: () async {
            final path = await getDirectoryPath(initialDirectory: widget.value);
            if (path == null) {
              return;
            }
            widget.onUpdate(path);
          },
          child: Text("..."),
        ),
        ...widget.actions
      ],
    );
  }

  Widget _editView(BuildContext context) {
    return MouseRegion(cursor: SystemMouseCursors.text, child: _editSinglelineView(context));
  }

  Widget _editSinglelineView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;

    return Field(
        label: this.widget.label,
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
              textAlign: TextAlign.end,
              selectionColor: Colors.black38,
              keyboardType: TextInputType.text,
              autofocus: true,
              inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
            ),
          ),
        ),
      actions: [
        FieldAction(
          onTap: () async {
            final path = await getDirectoryPath(initialDirectory: widget.value);
            if (path == null) {
              return;
            }
            widget.onUpdate(path);
          },
          child: Text("..."),
        ),
        ...widget.actions
      ],
    );
  }

  void _setValue(String value) {
    log("_setValue $value", name: "TextField");
    if (widget.value != value) {
      widget.onUpdate(value);
    }
  }
}
