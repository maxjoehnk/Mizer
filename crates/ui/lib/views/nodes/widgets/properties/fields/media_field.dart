import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/hoverable.dart';

import 'field.dart';

class MediaField extends StatefulWidget {
  final String label;
  final NodeSetting_MediaValue value;
  final Function(NodeSetting_MediaValue) onUpdate;
  final bool multiline;

  MediaField(
      {required this.label, required this.value, required this.onUpdate, this.multiline = false});

  @override
  _MediaFieldState createState() => _MediaFieldState(value.value);
}

class _MediaFieldState extends State<MediaField> {
  final FocusNode focusNode = FocusNode(debugLabel: "TextField");
  final TextEditingController controller = TextEditingController();

  bool isEditing = false;

  _MediaFieldState(String value) {
    this.controller.text = value;
  }

  @override
  void didUpdateWidget(MediaField oldWidget) {
    if (oldWidget.value != widget.value && widget.value.value != this.controller.text) {
      this.controller.text = widget.value.value;
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
        ),
        _mediaSelector(context)
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
          ),
          _mediaSelector(context)
        ]);
  }

  Widget _mediaSelector(BuildContext context) {
    return Hoverable(builder: (hovered) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.grey.shade700,
      ),
      clipBehavior: Clip.antiAlias,
      child: Icon(Icons.perm_media_outlined),
    ), onTap: () => _selectMedia(context));
  }

  void _setValue(String value) {
    log("_setValue $value", name: "MediaField");
    if (widget.value.value != value) {
      widget.onUpdate(NodeSetting_MediaValue(value: value, allowedTypes: widget.value.allowedTypes));
    }
  }
}
