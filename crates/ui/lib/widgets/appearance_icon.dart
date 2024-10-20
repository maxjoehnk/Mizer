import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mizer/protos/appearance.extensions.dart';
import 'package:mizer/protos/appearance.pb.dart' show Appearance;

class AppearanceIcon extends StatelessWidget {
  final Appearance appearance;

  const AppearanceIcon({required this.appearance, super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/icons/fixtures/${appearance.icon}.svg",
        color: appearance.hasColor() ? appearance.color.toMaterialColor() : Colors.white,
        width: 40,
        height: 40,
        placeholderBuilder: (context) => Placeholder());
  }
}
