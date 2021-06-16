import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/protos/transport.pb.dart';
import 'package:mizer/protos/transport.pbenum.dart';

class TransportPluginApi implements TransportApi {
  final MethodChannel channel = const MethodChannel("mizer.live/transport");
  final EventChannel transport = const EventChannel("mizer.live/transport/watch");

  @override
  Future<void> setBPM(double bpm) async {
    await channel.invokeMethod("setBPM", bpm);
  }

  @override
  Future<void> setState(TransportState state) async {
    await channel.invokeMethod("setState", state.value);
  }

  @override
  Stream<Transport> watchTransport() {
    return transport.receiveBroadcastStream().map((e) => Transport.fromBuffer(e));
  }
}
