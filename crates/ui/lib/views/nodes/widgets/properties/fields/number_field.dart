import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/widgets/text_field_focus.dart';


enum NumberFieldChangeDetection {
  Node,
  Value,
}

class NumberField extends StatefulWidget {
  final String? node;
  final String label;
  final double? labelWidth;
  final bool big;
  final num value;
  final num? min;
  final num? max;
  late final num step;
  late final num minHint;
  late final num maxHint;
  final bool fractions;
  final bool bar;
  final Function(num) onUpdate;
  final NumberFieldChangeDetection changeDetection;

  static final floatsOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));

  NumberField(
      {required this.label,
      required this.value,
      this.labelWidth,
      this.big = false,
      this.min,
      this.max,
      num? minHint,
      num? maxHint,
      this.fractions = false,
      num? step,
      this.bar = true,
      required this.onUpdate,
      this.node,
      this.changeDetection = NumberFieldChangeDetection.Node}) {
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

  _NumberFieldState(this.value) {
    this.controller.text = value.toString();
  }

  @override
  void didUpdateWidget(NumberField oldWidget) {
    if ((widget.changeDetection == NumberFieldChangeDetection.Node &&
            oldWidget.node != widget.node) ||
        (widget.changeDetection == NumberFieldChangeDetection.Value &&
            oldWidget.value != widget.value)) {
      setState(() {
        this.controller.text = widget.value.toString();
        value = widget.value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _setValue(value);
    controller.addListener(() {
      var value = num.tryParse(controller.text);
      if (value == null) {
        return;
      }
      value = _validateValue(value);
      this._setValue(value);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;

    var inner = TextFieldFocus(
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true),
        style: textStyle,
        textAlign: TextAlign.end,
        keyboardType: TextInputType.number,
        inputFormatters: [
          if (!widget.fractions) FilteringTextInputFormatter.allow(RegExp(r'[0-9\-]')),
          if (widget.fractions) FilteringTextInputFormatter.allow(RegExp(r'[0-9\-.]')),
          FilteringTextInputFormatter.singleLineFormatter,
        ],
      ),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.resizeLeftRight,
      child: Listener(
        onPointerSignal: (e) {
          if (e is PointerScrollEvent) {
            var delta = e.scrollDelta.dy > 0 ? -widget.step : widget.step;
            var next = this.value + delta;
            _dragValue(num.parse(next.toStringAsFixed(3)));
          }
        },
        child: GestureDetector(
            onHorizontalDragUpdate: (update) {
              var delta = (update.primaryDelta ?? 0) * widget.step;
              var next = this.value + delta;
              _dragValue(num.parse(next.toStringAsFixed(3)));
            },
            child: Field(
                label: this.widget.label,
                labelWidth: this.widget.labelWidth,
                big: widget.big,
                child: widget.bar
                    ? _Bar(
                  value: this._valueHint,
                  child: inner,
                )
                    : Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.centerRight,
                  child: inner,
                ))
        ),
      ),
    );
  }

  num get _maxHint {
    return widget.maxHint;
  }

  num get _minHint {
    return widget.minHint;
  }

  double get _valueHint {
    return value.toDouble().lerp(_minHint.toDouble(), _maxHint.toDouble());
  }

  void _dragValue(num value) {
    value = _validateValue(value);
    this.controller.text = value.toString();
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
    if (widget.min != null) {
      value = max(value, widget.min!);
    }
    if (widget.max != null) {
      value = min(value, widget.max!);
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
        padding: const EdgeInsets.symmetric(vertical: 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(BORDER_RADIUS),
            bottomRight: Radius.circular(BORDER_RADIUS),
          ),
          gradient: LinearGradient(colors: [
            Colors.deepOrange.shade500,
            Colors.deepOrange.shade500,
            Grey600,
            Grey600,
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
