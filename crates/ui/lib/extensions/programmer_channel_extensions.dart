import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/extensions/number_extensions.dart';

extension DisplayExtension on ProgrammerChannel {
  String toDisplayValue() {
    if (this.hasFader()) {
      return fader.toPercentage();
    }
    if (this.hasColor()) {
      return "R: ${color.red.toPercentage()} G: ${color.green.toPercentage()} B: ${color.blue.toPercentage()}";
    }

    return "";
  }
}
