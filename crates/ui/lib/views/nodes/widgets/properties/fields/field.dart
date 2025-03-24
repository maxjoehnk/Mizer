import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';

class Field extends StatelessWidget {
  final String label;
  final Widget child;
  final Widget? suffix;

  Field({required this.label, required this.child, this.suffix});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: INPUT_FIELD_HEIGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Grey700,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(BORDER_RADIUS),
                      bottomLeft: Radius.circular(BORDER_RADIUS)),
                ),
                child: Text(this.label, textAlign: TextAlign.start, style: TextStyle(fontSize: 14)),
              )),
          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                  decoration: BoxDecoration(
                    color: Grey600,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(BORDER_RADIUS),
                        bottomRight: Radius.circular(BORDER_RADIUS)),
                  ),
                  child: child)),
          if (suffix != null) suffix!
        ],
      ),
    );
  }
}
