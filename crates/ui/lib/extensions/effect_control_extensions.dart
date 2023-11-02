import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/extensions/string_extensions.dart';

extension EfectControlExtensions on EffectControl {
  String toDisplay() {
    return this.name.toCapitalCase();
  }
}
