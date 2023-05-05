import 'package:flutter/widgets.dart';

class Field extends StatelessWidget {
  final String label;
  final Widget child;

  Field({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(flex: 1, fit: FlexFit.tight, child: Text(this.label, textAlign: TextAlign.end)),
        Container(width: 8),
        Flexible(flex: 2, fit: FlexFit.tight, child: child)
      ],
    );
  }
}
