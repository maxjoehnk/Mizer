import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/state/status_bar_bloc.dart';

import 'battery.dart';
import 'clock.dart';
import 'cpu.dart';
import 'fps.dart';
import 'memory.dart';

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
              child: StatusBarCpu(),
            ),
            Container(
              width: 1,
              color: Colors.grey.shade600,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: StatusBarMemory(),
            ),
            Container(
              width: 1,
              color: Colors.grey.shade600,
            ),
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
