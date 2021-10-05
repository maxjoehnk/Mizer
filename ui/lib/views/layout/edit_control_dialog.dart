import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/color_extensions.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;

class EditControlDialog extends StatefulWidget {
  final LayoutControl control;

  const EditControlDialog({required this.control, Key? key}) : super(key: key);

  @override
  State<EditControlDialog> createState() => _EditControlDialogState(control.decoration);
}

class _EditControlDialogState extends State<EditControlDialog> {
  ControlDecorations decorations;

  _EditControlDialogState(this.decorations);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Configure Control"),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(decorations),
            child: Text("Confirm"))
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(child: Text("Color", textAlign: TextAlign.start)),
            Checkbox(value: decorations.hasColor, onChanged: (enabled) => setState(() => decorations.hasColor = enabled!)),
          ]),
          SizedBox(
            height: 256,
            child: Opacity(
              opacity: decorations.hasColor ? 1 : 0.5,
              child: IgnorePointer(
                ignoring: !decorations.hasColor,
                child: ColorWheelPicker(color: _color, onChanged: (c) => setState(() {
                  decorations.hasColor = true;
                  decorations.color_2 = fromFlutterColor(c);
                }), onWheel: (_) {}),
              ),
            ),
          ),
        ],
      )
    );
  }

  get _color {
    if (decorations.hasColor) {
      return decorations.color_2?.asFlutterColor;
    }
    return Colors.white;
  }
}

