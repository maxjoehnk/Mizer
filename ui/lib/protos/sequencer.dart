// @dart=2.11
import 'sequencer.pb.dart';

export 'sequencer.pb.dart';

const CueTriggerLabels = {
  CueTrigger.GO: "Go",
  CueTrigger.FOLLOW: "Follow",
  CueTrigger.BEATS: "Beats",
  CueTrigger.TIMECODE: "Timecode",
};

extension CueTriggerExtensions on CueTrigger {
  String toLabel() {
    return CueTriggerLabels[this];
  }
}
