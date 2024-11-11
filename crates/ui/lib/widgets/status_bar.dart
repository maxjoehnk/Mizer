import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mizer/api/contracts/status.dart';
import 'package:mizer/api/plugin/ffi/status.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/status_bar_bloc.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      color: Colors.grey.shade900,
      child: BlocBuilder<StatusBarCubit, StatusBarState>(
        builder: (context, state) => Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(state.message ?? '', style: Theme.of(context).textTheme.bodySmall),
            ),
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: StatusBarFps(),
            ),
            Container(
              width: 1,
              color: Colors.grey.shade600,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: StatusBarClock(),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusBarFps extends StatefulWidget {
  const StatusBarFps({
    super.key,
  });

  @override
  State<StatusBarFps> createState() => _StatusBarFpsState();
}

class _StatusBarFpsState extends State<StatusBarFps> with SingleTickerProviderStateMixin {
  StatusPointer? _statusPointer;
  late final Ticker ticker;
  double? _fps;

  @override
  void initState() {
    super.initState();
    context.read<StatusApi>().getStatusPointer().then((value) => _statusPointer = value);
    ticker = createTicker((elapsed) => setState(() {
      if (_statusPointer != null) {
        var fps = _statusPointer!.readFps();
        if (fps > 0) {
          this._fps = fps;
        }
      }
    }));
    ticker.start();
  }

  @override
  void dispose() {
    _statusPointer?.dispose();
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_fps == null) {
      return Container();
    }
    var fps = _fps!.toStringAsFixed(2);
    return Text('FPS $fps'.i18n, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "RobotoMono"));
  }
}

class StatusBarClock extends StatefulWidget {
  const StatusBarClock({
    super.key,
  });

  @override
  State<StatusBarClock> createState() => _StatusBarClockState();
}

class _StatusBarClockState extends State<StatusBarClock> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(Duration(milliseconds: 50), (timer) => setState(() {}));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(DateFormat('Hms').format(DateTime.now()),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "RobotoMono"));
  }
}
