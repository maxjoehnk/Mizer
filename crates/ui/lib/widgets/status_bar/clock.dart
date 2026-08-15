import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
