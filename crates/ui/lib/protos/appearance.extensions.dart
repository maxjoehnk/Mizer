import 'package:flutter/material.dart' as material;

import 'appearance.pb.dart';

extension AppearanceColorExtensions on Color {
  material.Color toMaterialColor() {
    return material.Color.fromARGB((this.alpha * 255).round(), (this.red * 255).round(),
        (this.green * 255).round(), (this.blue * 255).round());
  }
}
