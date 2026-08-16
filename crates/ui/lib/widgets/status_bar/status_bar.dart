import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/settings.pb.dart';
import 'package:mizer/state/settings_bloc.dart';
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
      child: BlocBuilder<SettingsBloc, Settings>(
        builder: (context, settings) {
          return BlocBuilder<StatusBarCubit, StatusBarState>(
            builder: (context, state) => Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(state.message ?? '', style: Theme.of(context).textTheme.bodySmall),
                ),
                Expanded(child: Container()),
                if (settings.ui.statusBar.batteryLevel)
                  StatusBarBattery(),
                StatusBarWidget(show: settings.ui.statusBar.cpuUsage, child: StatusBarCpu()),
                StatusBarWidget(show: settings.ui.statusBar.memoryUsage, child: StatusBarMemory()),
                StatusBarWidget(child: StatusBarFps()),
                StatusBarClock(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StatusBarWidget extends StatelessWidget {
  final bool show;
  final Widget child;

  const StatusBarWidget({super.key, this.show = true, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return Container();
    }

    return Container(
      decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.grey.shade600))),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: child,
    );
  }
}
