import 'sequencer.pb.dart';

export 'sequencer.pb.dart';

const CueTriggerLabels = {
  CueTrigger.GO: "Go",
  CueTrigger.FOLLOW: "Follow",
  CueTrigger.TIME: "Time",
  CueTrigger.BEATS: "Beats",
  CueTrigger.TIMECODE: "Timecode",
};

extension CueTriggerExtensions on CueTrigger {
  String toLabel() {
    return CueTriggerLabels[this]!;
  }
}
