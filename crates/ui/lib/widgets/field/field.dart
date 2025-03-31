import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/hoverable.dart';

const double _textSize = 13;
const double _bigTextSize = 15;

class Field extends StatelessWidget {
  final String? label;
  final double labelWidth;
  final bool vertical;
  final Widget child;
  final Widget? suffix;
  final bool big;
  final List<Widget> actions;

  Field({this.label, double? labelWidth, required this.child, this.suffix, this.vertical = false, this.big = false, this.actions = const []}) : labelWidth = labelWidth ?? 100;

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return VerticalField(label: label, child: child);
    } else {
      return HorizontalField(label: label, labelWidth: labelWidth, big: big, child: child, suffix: suffix, actions: actions);
    }
  }
}

class HorizontalField extends StatelessWidget {
  final String? label;
  final double labelWidth;
  final Widget child;
  final Widget? suffix;
  final List<Widget> actions;
  final bool big;

  const HorizontalField({this.label, this.labelWidth = 100, this.big = false, required this.child, this.suffix, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    var height = big ? BIG_INPUT_FIELD_HEIGHT : INPUT_FIELD_HEIGHT;
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (label != null)
            SizedBox(
                width: labelWidth,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Grey700,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(BORDER_RADIUS),
                        bottomLeft: Radius.circular(BORDER_RADIUS)),
                  ),
                  child: Text(label!, textAlign: TextAlign.center, style: TextStyle(fontSize: big ? _bigTextSize : _textSize)),
                )),
          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                  decoration: BoxDecoration(
                    color: Grey600,
                    borderRadius: label == null
                        ? BorderRadius.circular(BORDER_RADIUS)
                        : BorderRadius.only(
                        topRight: Radius.circular(BORDER_RADIUS),
                        bottomRight: Radius.circular(BORDER_RADIUS)),
                  ),
                  child: child)),
          if (suffix != null) suffix!,
          ...actions.map((action) => Container(
            decoration: BoxDecoration(
              color: Grey700,
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
            ),
            margin: EdgeInsets.only(left: 2),
            clipBehavior: Clip.antiAlias,
            width: height,
            child: action,
          )),
        ],
      ),
    );
  }
}


class VerticalField extends StatelessWidget {
  final String? label;
  final Widget child;

  const VerticalField({this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null)
          SizedBox(
              height: INPUT_FIELD_HEIGHT,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Grey700,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(BORDER_RADIUS),
                      topRight: Radius.circular(BORDER_RADIUS)),
                ),
                child: Text(label!, textAlign: TextAlign.center, style: TextStyle(fontSize: _textSize)),
              )),
        Container(
            decoration: BoxDecoration(
              color: Grey600,
              borderRadius: label == null
                  ? BorderRadius.circular(BORDER_RADIUS)
                  : BorderRadius.only(
                  bottomLeft: Radius.circular(BORDER_RADIUS),
                  bottomRight: Radius.circular(BORDER_RADIUS)),
            ),
            child: child),
      ],
    );
  }
}


class FieldAction extends StatelessWidget {
  final Function()? onTap;
  final Widget child;

  const FieldAction({super.key, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Hoverable(
        onTap: onTap,
        builder: (hovered) => Container(
              color: hovered ? Grey500 : Grey700,
              alignment: Alignment.center,
              child: child,
            ));
  }
}
