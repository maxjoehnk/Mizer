import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/protos/transport.pb.dart';

import 'ffi/api.dart';
import 'ffi/bindings.dart' show FFIBindings;
import 'ffi/transport.dart';

class TransportPluginApi implements TransportApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/transport");
  final EventChannel transport = const EventChannel("mizer.live/transport/watch");

  TransportPluginApi(this.bindings);

  @override
  Future<void> setBPM(double bpm) async {
    await channel.invokeMethod("setBPM", bpm);
  }

  @override
  Future<void> setFPS(double fps) async {
    await channel.invokeMethod("setFPS", fps);
  }

  @override
  Future<void> setState(TransportState state) async {
    await channel.invokeMethod("setState", state.value);
  }

  @override
  Stream<Transport> watchTransport() {
    return transport.receiveBroadcastStream().map((e) => Transport.fromBuffer(e));
  }

  @override
  Future<TransportPointer?> getTransportPointer() async {
    int pointer = await channel.invokeMethod("getTransportPointer");

    return this.bindings.openTransport(pointer);
  }
}
