import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/color_extensions.dart';
import 'package:mizer/i18n.dart';
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
        title: Text("Configure Control".i18n),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(decorations), child: Text("Confirm".i18n))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(child: Text("Color".i18n, textAlign: TextAlign.start)),
              Checkbox(
                  value: decorations.hasColor,
                  onChanged: (enabled) => setState(() => decorations.hasColor = enabled!)),
            ]),
            SizedBox(
              height: 256,
              child: Opacity(
                opacity: decorations.hasColor ? 1 : 0.5,
                child: IgnorePointer(
                  ignoring: !decorations.hasColor,
                  child: ColorWheelPicker(
                      color: _color,
                      onChanged: (c) => setState(() {
                            decorations.hasColor = true;
                            decorations.color_2 = fromFlutterColor(c);
                          }),
                      onWheel: (_) {}),
                ),
              ),
            ),
            Row(children: [
              Expanded(child: Text("Image".i18n, textAlign: TextAlign.start)),
              Checkbox(
                  value: decorations.hasImage,
                  onChanged: (enabled) => setState(() => decorations.hasImage = enabled!)),
            ]),
            SizedBox(
              height: 256,
              child: Opacity(
                opacity: decorations.hasImage ? 1 : 0.5,
                child: IgnorePointer(
                  ignoring: !decorations.hasImage,
                  child: ImagePicker(
                      image: _image,
                      onChanged: (c) => setState(() {
                            decorations.hasImage = true;
                            decorations.image_4 = c.toList();
                          })),
                ),
              ),
            )
          ],
        ));
  }

  Color get _color {
    if (decorations.hasColor) {
      return decorations.color_2.asFlutterColor;
    }
    return Colors.white;
  }

  Uint8List? get _image {
    if (decorations.hasImage) {
      return Uint8List.fromList(decorations.image_4);
    }
    return null;
  }
}

class ImagePicker extends StatelessWidget {
  final Uint8List? image;
  final Function(Uint8List) onChanged;

  const ImagePicker({required this.image, required this.onChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectFile(),
      child: _preview(),
    );
  }

  Widget _preview() {
    if (image == null || image!.isEmpty) {
      return Container(
        child: Center(child: Icon(Icons.image)),
      );
    }

    return Image(image: MemoryImage(image!));
  }

  _selectFile() async {
    const imageGroup = XTypeGroup(label: 'Images', extensions: ['jpg', 'jpeg', 'png']);
    XFile? image = await openFile(acceptedTypeGroups: [imageGroup]);
    if (image == null) {
      return;
    }
    Uint8List buffer = await image.readAsBytes();

    this.onChanged(buffer);
  }
}
