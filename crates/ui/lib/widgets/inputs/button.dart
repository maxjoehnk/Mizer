import 'package:flutter/material.dart';

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
    return Container(
        decoration: ControlDecoration(color: widget.color),
        clipBehavior: Clip.antiAlias,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTapDown: (_) {
                setState(() => this.pressed = true);
                this.widget.onValue(1);
              },
              onTapUp: (_) {
                setState(() => this.pressed = false);
                this.widget.onValue(0);
              },
              child: Container(
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
                      Center(
                          child: Text(widget.label!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall)),
                  ],
                ),
              )),
        ));
  }
}
