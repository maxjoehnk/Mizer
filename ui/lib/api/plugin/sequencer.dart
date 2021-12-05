import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/sequencer.pb.dart';

class SequencerPluginApi implements SequencerApi {
  final MethodChannel channel = const MethodChannel("mizer.live/sequencer");

  @override
  Future<Sequences> getSequences() async {
    var response = await channel.invokeMethod("getSequences");

    return Sequences.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<Sequence> addSequence() async {
    var response = await channel.invokeMethod("addSequence");

    return Sequence.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<void> sequenceGo(int sequence) async {
    await channel.invokeMethod("sequenceGo", sequence);
  }

  @override
  Future<Sequence> getSequence(int sequenceId) async {
    var response = await channel.invokeMethod("getSequence", sequenceId);

    return Sequence.fromBuffer(_convertBuffer(response));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  @override
  Future<Sequences> deleteSequence(int sequenceId) async {
    var response = await channel.invokeMethod("deleteSequence", sequenceId);

    return Sequences.fromBuffer(_convertBuffer(response));
  }
}
