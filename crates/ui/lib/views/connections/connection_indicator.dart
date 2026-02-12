import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/api/plugin/ffi/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:provider/provider.dart';

class ConnectionIndicator extends StatefulWidget {
  final Connection connection;

  const ConnectionIndicator(this.connection, {super.key});

  @override
  State<ConnectionIndicator> createState() => _ConnectionIndicatorState();
}

class _ConnectionIndicatorState extends State<ConnectionIndicator> with SingleTickerProviderStateMixin {
  Ticker? _ticker;
  ConnectionsPointer? _pointer;
  TransmissionState? _transmissionState;

  @override
  void initState() {
    super.initState();
    var connectionsApi = context.read<ConnectionsApi>();
    connectionsApi.getConnectionsPointer()
    .then((pointer) {
      _pointer = pointer;
      _ticker = Ticker((_) {
        setState(() {
          _transmissionState = _pointer!.readConnectionState(widget.connection.id);
        });
      });
      _ticker!.start();
    });
  }

  @override
  void dispose() {
    _pointer?.dispose();
    _ticker?.stop(canceled: true);
    super.dispose();
  }

  bool get isSending {
    return _transmissionState?.sending ?? false;
  }

  bool get isReceiving {
    return _transmissionState?.receiving ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 4, children: [
      Tooltip(
        message: "Out",
        waitDuration: Duration(milliseconds: 200),
        child: Container(
            decoration: BoxDecoration(
              color: isSending ? Colors.green : Colors.grey.shade700,
              borderRadius: BorderRadius.circular(8),
            ),
            width: 12,
            height: 12),
      ),
      Tooltip(
        message: "In",
        waitDuration: Duration(milliseconds: 200),
        child: Container(
            decoration: BoxDecoration(
              color: isReceiving ? Colors.red : Colors.grey.shade700,
              borderRadius: BorderRadius.circular(8),
            ),
            width: 12,
            height: 12),
      ),
    ]);
  }
}
