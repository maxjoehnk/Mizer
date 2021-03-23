import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NumberField extends StatefulWidget {
  final String label;
  final num value;
  final num min;
  final num max;
  num minHint;
  num maxHint;
  final bool fractions;

  final TextEditingController controller = TextEditingController();

  NumberField(
      {@required this.label,
      @required this.value,
      this.min,
      this.max,
      this.minHint,
      this.maxHint,
      this.fractions = false}) {
    this.controller.text = this.value.toString();
    this.minHint = this.minHint ?? this.min ?? 0;
    this.maxHint = this.maxHint ?? this.max ?? 1;
  }

  @override
  _NumberFieldState createState() => _NumberFieldState(this.value);
}

class _NumberFieldState extends State<NumberField> {
  final FocusNode focusNode = FocusNode(debugLabel: "NumberField");

  num value;
  bool isEditing = false;

  _NumberFieldState(this.value);

  @override
  void initState() {
    super.initState();
    this.focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          this.isEditing = false;
        });
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: this.isEditing ? _editView(context) : _readView(context),
    );
  }

  num get _maxHint {
    if (widget.max != null) {
      return widget.max;
    }
    return widget.maxHint;
  }

  num get _minHint {
    if (widget.min != null) {
      return widget.min;
    }
    return widget.minHint;
  }

  double get _valueHint {
    return value.toDouble().lerp(_minHint.toDouble(), _maxHint.toDouble());
  }

  Widget _readView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2;
    return MouseRegion(
      cursor: SystemMouseCursors.resizeLeftRight,
      child: GestureDetector(
        onHorizontalDragUpdate: (update) => _setValue(this.value + update.primaryDelta),
        onTap: () => setState(() => this.isEditing = true),
        child: _Field(
            label: this.widget.label,
            value: this._valueHint,
            child: Text(
              widget.controller.text,
              style: textStyle,
              textAlign: TextAlign.center,
            )),
      ),
    );
  }

  Widget _editView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2;

    return MouseRegion(
        cursor: SystemMouseCursors.resizeLeftRight,
        child: _Field(
          label: this.widget.label,
          value: this._valueHint,
          child: EditableText(
            focusNode: focusNode,
            controller: widget.controller,
            cursorColor: Colors.black87,
            backgroundCursorColor: Colors.black12,
            style: textStyle,
            textAlign: TextAlign.center,
            selectionColor: Colors.black38,
          ),
        ));
  }

  void _setValue(num value) {
    if (widget.min != null && widget.max != null) {
      value = value.clamp(widget.min, widget.max);
    }
    if (!this.widget.fractions) {
      value = value.truncate();
    }
    setState(() {
      this.value = value;
      this.widget.controller.text = this.value.toString();
    });
  }
}

class _Field extends StatelessWidget {
  final String label;
  final Widget child;
  final double value;

  _Field({this.label, this.child, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(flex: 1, fit: FlexFit.tight, child: Text(this.label)),
        Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade700,
                      Colors.grey.shade700,
                      Colors.grey.shade800,
                      Colors.grey.shade800,
                    ],
                    stops: [
                      0,
                      this.value,
                      this.value,
                      1,
                    ]
                  ),
                ),
                child: child))
      ],
    );
  }
}

extension InterpolationExtensions on double {
  double lerp(double min, double max) {
    return (this * (1 / (max - min)));
  }
}
