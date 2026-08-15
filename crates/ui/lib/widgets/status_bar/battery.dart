import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';

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

      return Text('${level.requireData}%', style: Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "RobotoMono"));
    });
  }
}
