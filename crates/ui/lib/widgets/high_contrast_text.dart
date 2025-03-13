import 'package:flutter/material.dart';

class HighContrastText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final double? fontSize;

  const HighContrastText(this.text, {this.textAlign, this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Text(text,
            style: textTheme.bodySmall!.copyWith(
              fontSize: fontSize,
              foreground: Paint()
                ..color = Colors.black
                ..strokeWidth = 3
                ..style = PaintingStyle.stroke,
            ),
            overflow: TextOverflow.clip,
            textAlign: textAlign,
            maxLines: 2),
        Text(text,
            style: textTheme.bodySmall!.copyWith(
              fontSize: fontSize,
            ),
            overflow: TextOverflow.clip,
            textAlign: textAlign,
            maxLines: 2),
      ],
    );
  }
}
