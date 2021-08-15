import 'package:flutter/widgets.dart';
import 'package:mizer/protos/layouts.pb.dart' as layouts;

extension ColorExtensions on layouts.Color {
  Color get asFlutterColor {
    return Color.fromARGB(
        255, (this.red * 255).toInt(), (this.green * 255).toInt(), (this.blue * 255).toInt());
  }
}

layouts.Color fromFlutterColor(Color color) {
  return layouts.Color(
    blue: color.blue / 255,
    green: color.green / 255,
    red: color.red / 255,
  );
}
