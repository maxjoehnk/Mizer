import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HighContrastText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final double? fontSize;
  final AutoSize? autoSize;

  const HighContrastText(this.text, {this.textAlign, this.fontSize = 15, this.autoSize, super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        AutoSizeText(text,
            minFontSize: this.autoSize?.minFontSize ?? 12,
            wrapWords: this.autoSize?.wrapWords ?? true,
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
        AutoSizeText(text,
            minFontSize: this.autoSize?.minFontSize ?? 12,
            wrapWords: this.autoSize?.wrapWords ?? true,
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

class AutoSize {
  final double? minFontSize;
  final bool wrapWords;

  const AutoSize({this.minFontSize, this.wrapWords = false});
}

// AutoSizeText(value,
//                 minFontSize: 10,
//                 wrapWords: false,
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodySmall!.copyWith(fontSize: 15))
