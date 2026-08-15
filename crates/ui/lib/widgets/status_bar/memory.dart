import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/status.dart';
import 'package:mizer/i18n.dart';
import 'package:provider/provider.dart';

class StatusBarMemory extends StatefulWidget {
  const StatusBarMemory({
    super.key,
  });

  @override
  State<StatusBarMemory> createState() => _StatusBarMemoryState();
}

class _StatusBarMemoryState extends State<StatusBarMemory> with SingleTickerProviderStateMixin {
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
    return FutureBuilder(future: context.read<StatusApi>().getMemoryUsage(), builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Container();
      }
      var memoryUsage = snapshot.requireData.toStringAsFixed(2);
      return Text('RAM {memory}%'.i18n.args({ 'memory': memoryUsage }), style: Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "RobotoMono"));
    });
  }
}
