import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/api/contracts/ui.dart';
import 'package:mizer/extensions/context_state_extensions.dart';
import 'package:mizer/protos/transport.pb.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/transport/beat_indicator.dart';

import 'time_control.dart';

const double TRANSPORT_CONTROLS_HEIGHT = 40;

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
    TransportApi apiClient = context.read();

    return Container(
        height: TRANSPORT_CONTROLS_HEIGHT,
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
        child: Row(children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            RepaintBoundary(
                child: BeatIndicator(apiClient,
                    beatStream: transportStream.map((event) => event.beat))),
            _Divider(),
            RepaintBoundary(
                child: SpeedControl(transportStream.map((event) => event.speed).distinct())),
            _Divider(),
            TransportButton(
                child: SizedBox(width: 64, child: Center(child: Text("Tap"))),
                onClick: () => apiClient.tap()),
            _Divider(),
            TransportButton(
                child: SizedBox(width: 64, child: Center(child: Text("Resync"))),
                onClick: () => apiClient.resync()),
            _Divider(width: 4),
            RepaintBoundary(child: TimeControl(apiClient, transportStream)),
            _Divider(),
            RepaintBoundary(
                child: TransportControl(transportStream.map((event) => event.state).distinct())),
            _Divider(width: 4),
            RepaintBoundary(
              child: FpsSelector(transportStream: transportStream),
            ),
            _Divider(width: 4),
          ]),
          SizedBox(width: 4),
          Expanded(child: CommandLineInput()),
          SizedBox(width: 4),
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

class FpsSelector extends StatelessWidget {
  final Stream<Transport> transportStream;

  const FpsSelector({super.key, required this.transportStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        stream: transportStream.map((event) => event.fps).distinct(),
        builder: (context, snapshot) {
          return Container(
            width: 96,
            height: TRANSPORT_CONTROLS_HEIGHT,
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
        });
  }
}

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
              TransportButton(
                  child: AspectRatio(aspectRatio: 1, child: Icon(Icons.stop)),
                  onClick: () => api.setState(TransportState.STOPPED),
                  active: snapshot.data == TransportState.STOPPED),
              SizedBox(width: 2),
              TransportButton(
                  child: AspectRatio(aspectRatio: 1, child: Icon(Icons.pause)),
                  onClick: () => api.setState(TransportState.PAUSED),
                  active: snapshot.data == TransportState.PAUSED),
              SizedBox(width: 2),
              TransportButton(
                  child: AspectRatio(aspectRatio: 1, child: Icon(Icons.play_arrow)),
                  onClick: () => api.setState(TransportState.PLAYING),
                  active: snapshot.data == TransportState.PLAYING),
            ]));
  }
}

class TransportButton extends StatelessWidget {
  final Widget child;
  final Function() onClick;
  final bool active;

  const TransportButton(
      {super.key, required this.child, required this.onClick, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Hoverable(
        onTap: active ? null : onClick,
        builder: (hover) => Container(
              color: active ? Colors.deepOrange : (hover ? Colors.white10 : Colors.transparent),
              child: child,
            ));
  }
}

class _Divider extends StatelessWidget {
  final double width;

  const _Divider({super.key, this.width = 2});

  @override
  Widget build(BuildContext context) {
    return Container(width: 2, color: Colors.black26);
  }
}

class CommandLineInput extends StatefulWidget {
  const CommandLineInput({super.key});

  @override
  State<CommandLineInput> createState() => _CommandLineInputState();
}

class _CommandLineInputState extends State<CommandLineInput> {
  TextEditingController controller = TextEditingController(text: '');
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: TRANSPORT_CONTROLS_HEIGHT - 8,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.black26),
      ),
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          if (controller.text.isEmpty)
            Center(
                child: Text("Commandline",
                    style: textTheme.bodyMedium!.copyWith(color: Colors.white54))),
          Center(
              child: EditableText(
            controller: controller,
            focusNode: focusNode,
            style: textTheme.bodyMedium!,
            autocorrect: false,
            cursorColor: Colors.black87,
            backgroundCursorColor: Colors.black12,
            textAlign: TextAlign.start,
            selectionColor: Colors.black38,
            keyboardType: TextInputType.text,
            inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
            onSubmitted: (value) {
              context.read<UiApi>().commandLineExecute(value)
              .then((value) => context.refreshAllStates());
              controller.clear();
            },
          )),
        ],
      ),
    );
  }
}
