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
    if (this.control == FixtureControl.GENERIC) {
      return this.genericChannel;
    }
    return this.control.name.toCapitalCase();
  }
}
