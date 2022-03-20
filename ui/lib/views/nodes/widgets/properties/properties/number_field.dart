import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';

class NumberField extends StatefulWidget {
  final String label;
  final num value;
  final num? min;
  final num? max;
  late final num step;
  late final num minHint;
  late final num maxHint;
  final bool fractions;
  final Function(num) onUpdate;

  static final floatsOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));

  NumberField(
      {required this.label,
      required this.value,
      this.min,
      this.max,
      num? minHint,
      num? maxHint,
      this.fractions = false,
      num? step,
      required this.onUpdate}) {
    this.minHint = minHint ?? this.min ?? 0;
    this.maxHint = maxHint ?? this.max ?? 1;
    this.step = step ?? (this.fractions ? 0.1 : 1);
  }

  @override
  _NumberFieldState createState() => _NumberFieldState(this.value);
}

class _NumberFieldState extends State<NumberField> {
  final FocusNode focusNode = FocusNode(debugLabel: "NumberField");
  final TextEditingController controller = TextEditingController();

  num value;
  bool isEditing = false;

  _NumberFieldState(this.value) {
    this.controller.text = value.toString();
  }

  @override
  void didUpdateWidget(NumberField oldWidget) {
    if (oldWidget.value != widget.value && widget.value != this.value) {
      this.controller.text = widget.value.toString();
      setState(() {
        value = widget.value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _setValue(value);
    this.focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          this.isEditing = false;
        });
      }
    });
    controller.addListener(() {
      var value = num.parse(controller.text);
      value = _validateValue(value);
      this._setValue(value);
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
      return widget.max!;
    }
    return widget.maxHint!;
  }

  num get _minHint {
    if (widget.min != null) {
      return widget.min!;
    }
    return widget.minHint!;
  }

  double get _valueHint {
    return value.toDouble().lerp(_minHint.toDouble(), _maxHint.toDouble());
  }

  Widget _readView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2!;
    return MouseRegion(
      cursor: SystemMouseCursors.resizeLeftRight,
      child: GestureDetector(
        onHorizontalDragUpdate: (update) {
          var delta = (update.primaryDelta ?? 0) * widget.step;
          var next = this.value + delta;
          _dragValue(num.parse(next.toStringAsFixed(3)));
        },
        onTap: () => setState(() => this.isEditing = true),
        child: Field(
          label: this.widget.label,
          child: _Bar(
              value: this._valueHint,
              child: Text(
                controller.text,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }

  Widget _editView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2!;

    return MouseRegion(
        cursor: SystemMouseCursors.resizeLeftRight,
        child: Field(
          label: this.widget.label,
          child: _Bar(
            value: this._valueHint,
            child: EditableText(
              focusNode: focusNode,
              controller: controller,
              cursorColor: Colors.black87,
              backgroundCursorColor: Colors.black12,
              style: textStyle,
              textAlign: TextAlign.center,
              selectionColor: Colors.black38,
              keyboardType: TextInputType.number,
              autofocus: true,
              inputFormatters: [
                if (!widget.fractions) FilteringTextInputFormatter.digitsOnly,
                if (widget.fractions) NumberField.floatsOnly,
                FilteringTextInputFormatter.singleLineFormatter,
              ],
            ),
          ),
        ));
  }

  void _dragValue(num value) {
    value = _validateValue(value);
    this.controller.text = this.value.toString();
    _setValue(value);
  }

  void _setValue(num value) {
    log("setValue $value", name: "NumberField");
    setState(() {
      this.value = value;
    });
    if (widget.value != value) {
      widget.onUpdate(value);
    }
  }

  num _validateValue(num value) {
    if (widget.min != null && widget.max != null) {
      value = value.clamp(widget.min!, widget.max!);
    }
    if (!this.widget.fractions) {
      value = value.truncate();
    }
    return value;
  }
}

class _Bar extends StatelessWidget {
  final Widget? child;
  final double value;

  _Bar({this.child, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          gradient: LinearGradient(colors: [
            Colors.grey.shade700,
            Colors.grey.shade700,
            Colors.grey.shade800,
            Colors.grey.shade800,
          ], stops: [
            0,
            this.value,
            this.value,
            1,
          ]),
        ),
        child: child);
  }
}

extension InterpolationExtensions on double {
  double lerp(double min, double max) {
    return (this * (1 / (max - min)));
  }
}
