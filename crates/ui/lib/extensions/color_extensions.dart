import 'package:flutter/widgets.dart';
import 'package:mizer/protos/layouts.pb.dart' as layouts;
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/inputs/color.dart';

extension ColorExtensions on layouts.Color {
  Color get asFlutterColor {
    return Color.fromARGB(
        255, (this.red * 255).toInt(), (this.green * 255).toInt(), (this.blue * 255).toInt());
  }
}

extension ColorValueExtensions on ColorValue {
  Color get asFlutterColor {
    return Color.fromARGB(
        255, (this.red * 255).toInt(), (this.green * 255).toInt(), (this.blue * 255).toInt());
  }
}

extension NodeSettingColorValueExtensions on NodeSetting_ColorValue {
  Color get asFlutterColor {
    return Color.fromARGB(
        255, (this.red * 255).toInt(), (this.green * 255).toInt(), (this.blue * 255).toInt());
  }
}

layouts.Color fromFlutterColor(Color color) {
  return layouts.Color(
    blue: color.b / 255,
    green: color.g / 255,
    red: color.r / 255,
  );
}
