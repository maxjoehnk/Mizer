import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';

extension FixtureFaderControlExtensions on FixtureFaderControl {
  String toDisplay() {
    if (this.control == FixtureControl.COLOR_MIXER) {
      return "Color Mixer - ${this.colorMixerChannel.name.toCapitalCase()}";
    }
    if (this.control == FixtureControl.COLOR_WHEEL) {
      return "Color Wheel";
    }
    return this.control.name.toCapitalCase();
  }
}
