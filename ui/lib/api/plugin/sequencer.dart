import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/sequencer.dart';

import 'ffi/api.dart';
import 'ffi/bindings.dart';
import 'ffi/sequencer.dart';

class SequencerPluginApi implements SequencerApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/sequencer");

  SequencerPluginApi(this.bindings);

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

  @override
  Future<Sequences> deleteSequence(int sequenceId) async {
    var response = await channel.invokeMethod("deleteSequence", sequenceId);

    return Sequences.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<Sequences> updateCueTrigger(int sequence, int cue, CueTrigger trigger) async {
    var request = CueTriggerRequest(sequence: sequence, cue: cue, trigger: trigger);
    var response = await channel.invokeMethod("updateCueTrigger", request.writeToBuffer());

    return Sequences.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<SequencerPointer?> getSequencerPointer() async {
    int pointer = await channel.invokeMethod("getSequencerPointer");

    return this.bindings.openSequencer(pointer);
  }

  @override
  Future<Sequences> updateCueName(int sequence, int cue, String name) async {
    var request = CueNameRequest(sequence: sequence, cue: cue, name: name);
    var response = await channel.invokeMethod("updateCueName", request.writeToBuffer());

    return Sequences.fromBuffer(_convertBuffer(response));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}
