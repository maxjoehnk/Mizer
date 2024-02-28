import 'sequencer.pb.dart';

export 'sequencer.pb.dart';

final CueTriggerLabels = {
  CueTrigger_Type.GO: "Go",
  CueTrigger_Type.FOLLOW: "Follow",
  CueTrigger_Type.TIME: "Time",
  CueTrigger_Type.BEATS: "Beats",
  CueTrigger_Type.TIMECODE: "Timecode",
};

extension CueTriggerExtensions on CueTrigger {
  String toLabel() {
    return CueTriggerLabels[this.type]!;
  }
}
