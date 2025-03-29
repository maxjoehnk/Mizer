import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/widgets/hoverable.dart';

const double _textSize = 13;

class Field extends StatelessWidget {
  final String? label;
  final bool vertical;
  final Widget child;
  final Widget? suffix;
  final List<Widget> actions;

  Field({this.label, required this.child, this.suffix, this.vertical = false, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return VerticalField(label: label, child: child);
    } else {
      return HorizontalField(label: label, child: child, suffix: suffix, actions: actions);
    }
  }
}

class HorizontalField extends StatelessWidget {
  final String? label;
  final Widget child;
  final Widget? suffix;
  final List<Widget> actions;

  const HorizontalField({this.label, required this.child, this.suffix, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: INPUT_FIELD_HEIGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (label != null)
            SizedBox(
                width: 100,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Grey700,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(BORDER_RADIUS),
                        bottomLeft: Radius.circular(BORDER_RADIUS)),
                  ),
                  child: Text(label!, textAlign: TextAlign.center, style: TextStyle(fontSize: _textSize)),
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
          ...actions.mapEnumerated((a, i) => Container(
            decoration: BoxDecoration(
              color: Grey700,
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
            ),
            margin: EdgeInsets.only(left: 2),
            clipBehavior: Clip.antiAlias,
            width: INPUT_FIELD_HEIGHT,
            child: a,
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
                      bottomLeft: Radius.circular(BORDER_RADIUS)),
                ),
                child: Text(label!, textAlign: TextAlign.center, style: TextStyle(fontSize: _textSize)),
              )),
        Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Grey600,
              borderRadius: label == null
                  ? BorderRadius.circular(BORDER_RADIUS)
                  : BorderRadius.only(
                  topRight: Radius.circular(BORDER_RADIUS),
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
