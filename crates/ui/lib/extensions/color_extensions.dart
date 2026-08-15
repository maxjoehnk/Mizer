import 'package:flex_color_picker/flex_color_picker.dart';
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

extension FlutterColorExtensions on Color {
  Color get dimmed {
    return Color.fromARGB(alpha8bit, _dim(r), _dim(g), _dim(b));
  }
}

int _dim(double value, { double modifier = 0.5 }) {
  return ((value * modifier) * 255).toInt();
}
