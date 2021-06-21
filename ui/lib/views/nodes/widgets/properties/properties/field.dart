import 'package:flutter/widgets.dart';

class Field extends StatelessWidget {
  final String label;
  final Widget child;

  Field({this.label, this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(flex: 1, fit: FlexFit.tight, child: Text(this.label)),
        Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: child)
      ],
    );
  }
}

