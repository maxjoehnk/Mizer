import 'package:flutter/widgets.dart';

class ColorIndicator extends StatelessWidget {
  final Color? color;

  const ColorIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    if (color == null) {
      return Container();
    }
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
