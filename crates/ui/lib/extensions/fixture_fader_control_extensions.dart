import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/i18n.dart';

extension FixtureFaderControlExtensions on FixtureFaderControl {
  String toDisplay() {
    if (this.control == FixtureControl.COLOR_MIXER) {
      return "Color Mixer - ${this.colorMixerChannel.name.toCapitalCase()}".i18n;
    }
    if (this.control == FixtureControl.COLOR_WHEEL) {
      return "Color Wheel".i18n;
    }
    if (this.control == FixtureControl.GENERIC) {
      return this.genericChannel;
    }
    return this.control.name.toCapitalCase().i18n;
  }
}
