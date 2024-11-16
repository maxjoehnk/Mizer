import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:provider/provider.dart';

class SpeedControl extends StatelessWidget {
  final Stream<double> bpm;

  const SpeedControl(this.bpm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 96,
        child: StreamBuilder<double>(
            stream: bpm,
            initialData: 0,
            builder: (context, snapshot) => Center(
              child: SpeedEditor(
                  value: snapshot.data!,
                  onUpdate: (bpm) => context.read<TransportApi>().setBPM(bpm)),
            )));
  }
}

class SpeedEditor extends StatefulWidget {
  final double value;
  final Function(double) onUpdate;

  static final floatsOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));

  const SpeedEditor({required this.value, required this.onUpdate, Key? key}) : super(key: key);

  @override
  State<SpeedEditor> createState() => _SpeedEditorState(value);
}

class _SpeedEditorState extends State<SpeedEditor> {
  final FocusNode focusNode = FocusNode(debugLabel: "SpeedEditor");
  final TextEditingController controller = TextEditingController();
  double value;
  bool isEditing = false;

  _SpeedEditorState(this.value) {
    this.controller.text = value.toString();
  }

  @override
  void didUpdateWidget(SpeedEditor oldWidget) {
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
        var value = double.parse(controller.text);
        this._setValue(value);
        setState(() {
          this.isEditing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.isEditing ? _editView(context) : _readView(context);
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  Widget _readView(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return MouseRegion(
      cursor: SystemMouseCursors.resizeLeftRight,
      child: Listener(
        onPointerSignal: (e) {
          if (e is PointerScrollEvent) {
            var delta = e.scrollDelta.dy > 0 ? -1 : 1;
            var next = this.value + delta;
            _dragValue(double.parse(next.toStringAsFixed(3)));
          }
        },
        child: GestureDetector(
          onHorizontalDragUpdate: (update) {
            var delta = update.primaryDelta ?? 0;
            var next = this.value + delta;
            _dragValue(double.parse(next.toStringAsFixed(3)));
          },
          onTap: () => setState(() => this.isEditing = true),
          child: Text(value.toStringAsFixed(2),
              textAlign: TextAlign.center, style: style.headlineSmall!.copyWith(fontFamily: "RobotoMono", fontSize: 20)),
        ),
      ),
    );
  }

  Widget _editView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineSmall!;

    return EditableText(
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
        SpeedEditor.floatsOnly,
        FilteringTextInputFormatter.singleLineFormatter,
      ],
    );
  }

  void _dragValue(double value) {
    this.controller.text = this.value.toString();
    _setValue(value);
  }

  void _setValue(double value) {
    value = value.clamp(0, 300);
    setState(() {
      this.value = value;
    });
    if (widget.value != value) {
      widget.onUpdate(value);
    }
  }
}
