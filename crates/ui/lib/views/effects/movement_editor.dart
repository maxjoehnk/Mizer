import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/panel.dart';

import 'package:mizer/views/effects/movement_painter.dart';

class MovementEditor extends StatelessWidget {
  final Effect effect;

  const MovementEditor({required this.effect, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pan = effect.channels.firstWhereOrNull((element) => element.control == FixtureControl.PAN);
    var tilt =
    effect.channels.firstWhereOrNull((element) => element.control == FixtureControl.TILT);

    return Panel(
        label: "Movement".i18n,
        child: CustomPaint(painter: MovementPainter(pan, tilt), size: Size.infinite));
  }
}
