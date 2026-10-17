import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/layouts.pb.dart' as layouts;

extension ColorExtensions on layouts.Color {
  Color get asFlutterColor {
    return mapToColor(red, green, blue, amber: hasAmber() ? amber : null);
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

Color mapToColor(double red, double green, double blue, { double? amber }) {
    if (amber != null) {
      red   += amber * 1;
      green += amber * 0.75;
      blue  += amber * 0;

      red /= 1 + amber;
      green /= 1 + amber;
      blue /= 1 + amber;
    }

    return Color.fromARGB(255, (red.clamp(0, 1) * 255).toInt(), (green.clamp(0, 1) * 255).toInt(), (blue.clamp(0, 1) * 255).toInt());
}
