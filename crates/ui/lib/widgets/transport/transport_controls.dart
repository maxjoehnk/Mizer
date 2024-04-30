import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/protos/transport.pb.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/panel.dart';

import 'time_control.dart';

const double TRANSPORT_CONTROLS_HEIGHT = 64;

class TransportControls extends StatefulWidget {
  final bool showProgrammer;
  final bool showSelection;
  final bool showConsole;
  final Function() toggleProgrammer;
  final Function() toggleSelection;
  final Function() toggleConsole;

  TransportControls(
      {required this.showProgrammer,
      required this.toggleProgrammer,
      required this.showSelection,
      required this.toggleSelection,
      required this.showConsole,
      required this.toggleConsole});

  @override
  State<TransportControls> createState() => _TransportControlsState();
}

class _TransportControlsState extends State<TransportControls> {
  late Stream<Transport> transportStream;

  @override
  void initState() {
    super.initState();
    var api = context.read<TransportApi>();
    this.transportStream = api.watchTransport().asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    NodesApi apiClient = context.read();

    return Container(
        height: TRANSPORT_CONTROLS_HEIGHT,
        color: Colors.grey.shade800,
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RepaintBoundary(child: TimeControl(context.read(), transportStream)),
          ),
          RepaintBoundary(
              child: SpeedControl(transportStream.map((event) => event.speed).distinct())),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hoverable(
              onTap: () => apiClient.writeControlValue(path: "/transport-0", port: "Tap", value: 1),
              builder: (hover) => Container(
                  width: 64,
                  margin: const EdgeInsets.only(left: 4),
                  color: hover ? Colors.black45 : Colors.black26,
                  child: Center(child: Text("Tap"))),
            ),
          ),
          RepaintBoundary(
              child: TransportControl(transportStream.map((event) => event.state).distinct())),
          SizedBox(width: 8),
          RepaintBoundary(
            child: StreamBuilder<double>(
                stream: transportStream.map((event) => event.fps).distinct(),
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.grey.shade900,
                    width: 96,
                    height: 32,
                    padding: const EdgeInsets.all(4),
                    child: MizerSelect<double>(
                      openTop: true,
                      options: [
                        SelectOption(label: "30 FPS", value: 30),
                        SelectOption(label: "60 FPS", value: 60),
                      ],
                      onChanged: (fps) => context.read<TransportApi>().setFPS(fps),
                      value: snapshot.data ?? 60,
                    ),
                  );
                }),
          ),
          Spacer(),
          PanelAction(
              width: 80,
              action: PanelActionModel(
                label: "Console",
                hotkeyId: "console_pane",
                onClick: widget.toggleConsole,
                activated: widget.showConsole,
              )),
          PanelAction(
              width: 80,
              action: PanelActionModel(
                label: "Selection",
                hotkeyId: "selection_pane",
                onClick: widget.toggleSelection,
                activated: widget.showSelection,
              )),
          PanelAction(
              width: 80,
              action: PanelActionModel(
                label: "Programmer",
                hotkeyId: "programmer_pane",
                onClick: widget.toggleProgrammer,
                activated: widget.showProgrammer,
              )),
        ]));
  }
}

class SpeedControl extends StatelessWidget {
  final Stream<double> bpm;

  const SpeedControl(this.bpm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 96,
        color: Colors.grey.shade900,
        child: StreamBuilder<double>(
            stream: bpm,
            initialData: 0,
            builder: (context, snapshot) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SpeedEditor(
                    value: snapshot.data!,
                    onUpdate: (bpm) => context.read<TransportApi>().setBPM(bpm)))));
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
          child:
              Text(value.toStringAsFixed(2), textAlign: TextAlign.center, style: style.headline5),
        ),
      ),
    );
  }

  Widget _editView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline5!;

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
    log("setValue $value", name: "SpeedEditor");
    value = value.clamp(0, 300);
    setState(() {
      this.value = value;
    });
    if (widget.value != value) {
      widget.onUpdate(value);
    }
  }
}

class TransportControl extends StatelessWidget {
  final Stream<TransportState> state;

  TransportControl(this.state);

  @override
  Widget build(BuildContext context) {
    var api = context.read<TransportApi>();
    return StreamBuilder(
        stream: state,
        initialData: TransportState.PLAYING,
        builder: (context, snapshot) => Row(children: [
              Container(
                  margin: const EdgeInsets.only(left: 4),
                  color: snapshot.data == TransportState.STOPPED ? Colors.deepOrange : null,
                  child: IconButton(
                      onPressed: () => api.setState(TransportState.STOPPED),
                      icon: Icon(Icons.stop))),
              Container(
                  margin: const EdgeInsets.only(left: 4),
                  color: snapshot.data == TransportState.PAUSED ? Colors.deepOrange : null,
                  child: IconButton(
                      onPressed: () => api.setState(TransportState.PAUSED),
                      icon: Icon(Icons.pause))),
              Container(
                  margin: const EdgeInsets.only(left: 4),
                  color: snapshot.data == TransportState.PLAYING ? Colors.deepOrange : null,
                  child: IconButton(
                      onPressed: () => api.setState(TransportState.PLAYING),
                      icon: Icon(Icons.play_arrow))),
            ]));
  }
}
