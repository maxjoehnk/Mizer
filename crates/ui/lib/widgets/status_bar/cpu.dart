import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/status.dart';
import 'package:mizer/i18n.dart';
import 'package:provider/provider.dart';

class StatusBarCpu extends StatefulWidget {
  const StatusBarCpu({
    super.key,
  });

  @override
  State<StatusBarCpu> createState() => _StatusBarCpuState();
}

class _StatusBarCpuState extends State<StatusBarCpu> with SingleTickerProviderStateMixin {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(Duration(seconds: 1), (timer) => setState(() {}));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: context.read<StatusApi>().getCpuUsage(), builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Container();
      }
      var cpuUsage = snapshot.requireData.toStringAsFixed(2);
      return Text('CPU {cpu}%'.i18n.args({ 'cpu': cpuUsage }), style: Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "RobotoMono"));
    });
  }
}
