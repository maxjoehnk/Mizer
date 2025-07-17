import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/transport.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/widgets/hotkey_formatter.dart';
import 'package:mizer/widgets/hoverable.dart';

import 'beat_indicator.dart';
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
        child: Row(spacing: 2, children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Grey800,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(BORDER_RADIUS),
                  bottomRight: Radius.circular(BORDER_RADIUS),
                ),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
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
                SizedBox(width: 4),
                Expanded(child: CommandLineInput()),
                SizedBox(width: 4),
              ]),
            ),
          ),
          PlaybackBarButton(
            label: "Console",
            hotkeyId: "console_pane",
            onTap: widget.toggleConsole,
            active: widget.showConsole,
          ),
          PlaybackBarButton(
            label: "Selection",
            hotkeyId: "selection_pane",
            onTap: widget.toggleSelection,
            active: widget.showSelection,
          ),
          PlaybackBarButton(
            label: "Programmer",
            hotkeyId: "programmer_pane",
            onTap: widget.toggleProgrammer,
            active: widget.showProgrammer,
          ),
        ]));
  }
}

class PlaybackBarButton extends StatelessWidget {
  final String label;
  final String? hotkeyId;
  final bool active;
  final Function()? onTap;
  final WidgetBuilder? popupBuilder;

  const PlaybackBarButton(
      { required this.label, this.hotkeyId, super.key, this.onTap, this.popupBuilder, this.active = false });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var hotkey = _getHotkey(context);

    return Hoverable(
      onTap: onTap,
      builder: (hovered) =>
          Container(
            height: GRID_2_SIZE,
            width: GRID_5_SIZE,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
              color: active ? Grey600 : (hovered ? Grey700 : Grey800),
            ),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label,
                    textAlign: TextAlign.center),
                if (hotkey != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(formatHotkey(hotkey),
                        style: textTheme.bodySmall!.copyWith(color: Colors.white54, fontSize: 10)),
                  ),
              ],
            ),
          ),
    );
  }

  String? _getHotkey(BuildContext context) {
    var hotkeys = context.read<HotkeyMapping?>();
    if (hotkeys?.mappings == null) {
      return null;
    }
    return hotkeys!.mappings[hotkeyId];
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
    return Container(width: 2, color: Grey700);
  }
}
