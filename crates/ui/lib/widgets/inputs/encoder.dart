import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/panes/programmer/sheets/fixture_group_control.dart';
import 'package:mizer/widgets/popup/popup_programmer_input.dart';
import 'package:mizer/widgets/popup/popup_route.dart';
import 'package:provider/provider.dart';

import 'decoration.dart';

const double EncoderSize = 40;
const double EncoderBorderWidth = 4;

class EncoderInput extends StatefulWidget {
  final Function(double)? onValue;
  final double value;
  final String? label;
  final bool highlight;
  final List<Preset>? globalPresets;
  final List<ControlPreset>? controlPresets;

  EncoderInput(
      {this.onValue,
      required this.value,
      this.label,
      this.highlight = false,
      this.globalPresets,
      this.controlPresets});

  @override
  _EncoderInputState createState() => _EncoderInputState(value);
}

class _EncoderInputState extends State<EncoderInput> {
  double value = 0;

  _EncoderInputState(this.value);

  @override
  void didUpdateWidget(EncoderInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      this.value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    var percentage = (value * 100).toStringAsFixed(1);
    var textTheme = Theme.of(context).textTheme;
    ProgrammerApi programmerApi = context.read();
    return LayoutBuilder(
      builder: (context, constraints) => Listener(
        onPointerSignal: (event) {
          var delta = 0.1;
          if (RawKeyboard.instance.keysPressed.any((key) => [
            LogicalKeyboardKey.shift,
            LogicalKeyboardKey.shiftLeft,
            LogicalKeyboardKey.shiftRight,
          ].contains(key))) {
            delta = 0.01;
          }
          if (event is PointerScrollEvent) {
            _onScroll(event.scrollDelta.direction, delta);
          }
        },
        child: GestureDetector(
          onTapDown: (event) => Navigator.of(context).push(MizerPopupRoute(
              position: event.globalPosition,
              child: Provider.value(
                value: programmerApi,
                child: PopupProgrammerInput(
                  allowRange: false,
                  value: CueValue(direct: value * 100),
                  controlPresets: widget.controlPresets,
                  globalPresets: widget.globalPresets,
                  onEnter: (event) {
                    if (event.hasDirect()) {
                      _emitUpdate(event.direct);
                    }
                  },
                ),
              ))),
          child: Container(
            decoration: ControlDecoration(highlight: widget.highlight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.label != null)
                  Container(
                      height: 32,
                      color: widget.highlight == true
                          ? HIGHLIGHT_CONTROL_COLOR
                          : DEFAULT_CONTROL_COLOR,
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                      child: Text(widget.label ?? "",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall)),
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 16),
                            width: EncoderSize,
                            height: EncoderSize,
                            child: Container(
                              padding: const EdgeInsets.all(EncoderBorderWidth),
                              width: EncoderSize - (EncoderBorderWidth * 2),
                              height: EncoderSize - (EncoderBorderWidth * 2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.highlight == true
                                    ? HIGHLIGHT_CONTROL_COLOR
                                    : DEFAULT_CONTROL_COLOR,
                              ),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: SweepGradient(
                                    colors: [Colors.deepOrange, DEFAULT_CONTROL_COLOR],
                                    stops: [value, value],
                                    transform: GradientRotation(-1 * pi))),
                            alignment: AlignmentDirectional.center),
                        Expanded(
                            child: Text(
                          "$percentage%",
                          textAlign: TextAlign.center,
                          style: textTheme.titleMedium,
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onScroll(double direction, double delta) {
    double _value = value;
    if (direction < 0) {
      _value += delta;
    } else {
      _value -= delta;
    }
    _value = _value.clamp(0.0, 1.0);
    _emitUpdate(_value);
  }

  void _emitUpdate(double value) {
    setState(() {
      this.value = value;
    });
    if (this.widget.onValue != null) {
      this.widget.onValue!(value);
    }
  }
}
