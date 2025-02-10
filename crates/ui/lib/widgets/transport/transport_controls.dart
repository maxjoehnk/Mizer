import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/transport.pb.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/transport/beat_indicator.dart';

import 'command_line.dart';
import 'fps_control.dart';
import 'speed_control.dart';
import 'time_control.dart';

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
