import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mizer/api/contracts/status.dart';
import 'package:mizer/api/plugin/ffi/status.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/status_bar_bloc.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      color: Grey900,
      child: BlocBuilder<StatusBarCubit, StatusBarState>(
        builder: (context, state) => Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(state.message ?? '', style: Theme.of(context).textTheme.bodySmall),
            ),
            Expanded(child: Container()),
            StatusBarBattery(),
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

class StatusBarBattery extends StatefulWidget {
  const StatusBarBattery({super.key});

  @override
  State<StatusBarBattery> createState() => _StatusBarBatteryState();
}

class _StatusBarBatteryState extends State<StatusBarBattery> {
  final Battery battery = Battery();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: battery.onBatteryStateChanged, builder: (context, state) {
      if (!state.hasData) {
        return Container();
      }

      if (state.requireData == BatteryState.unknown) {
        return Container();
      }

      return Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text("BAT".i18n, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(width: 4),
            BatteryLevel(battery: battery),
          ]),
        ),
        Container(
          width: 1,
          color: Colors.grey.shade600,
        ),
      ]);
    });
  }
}

class BatteryLevel extends StatefulWidget {
  final Battery battery;

  const BatteryLevel({super.key, required this.battery});

  @override
  State<BatteryLevel> createState() => _BatteryLevelState();
}

class _BatteryLevelState extends State<BatteryLevel> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(Duration(seconds: 5), (timer) => setState(() {}));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: widget.battery.batteryLevel, builder: (context, level) {
      if (!level.hasData) {
        return Container();
      }

      return Text('${level.requireData}%'.i18n, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "RobotoMono"));
    });
  }
}
