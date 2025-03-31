import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/high_contrast_text.dart';

import 'decoration.dart';

class ButtonInput extends StatefulWidget {
  final Function(double) onValue;
  final String? label;
  final Color? color;
  final MemoryImage? image;
  final bool? pressed;

  ButtonInput({this.label, required this.onValue, this.color, this.image, this.pressed});

  @override
  _ButtonInputState createState() => _ButtonInputState();
}

class _ButtonInputState extends State<ButtonInput> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return PanelGridTile(
      color: widget.color,
      onTapDown: (_) {
        setState(() => this.pressed = true);
        this.widget.onValue(1);
      },
      onTapUp: (_) {
        setState(() => this.pressed = false);
        this.widget.onValue(0);
      },
      child: Stack(
        children: [
          if (widget.image != null)
            Positioned.fill(child: Image(image: widget.image!, fit: BoxFit.cover)),
          Container(
            margin: const EdgeInsets.all(4),
            decoration: ShapeDecoration(
              color: (this.pressed || (widget.pressed ?? false))
                  ? Colors.black45
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                  child: HighContrastText(widget.label!,
                      autoSize: AutoSize(
                        minFontSize: 10,
                        wrapWords: false,
                      ),
                      textAlign: TextAlign.center)),
            ),
        ],
      ),
    );
  }
}
