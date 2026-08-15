import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/contracts/status.dart';
import 'package:mizer/api/plugin/ffi/status.dart';
import 'package:mizer/i18n.dart';
import 'package:provider/provider.dart';

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
    return Text('FPS {fps}'.i18n.args({ 'fps': fps }), style: Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "RobotoMono"));
  }
}
