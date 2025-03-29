import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';

const double _spacing = 8;

class DialogTileGrid extends StatelessWidget {
  final List<Widget> children;
  final int? columns;

  const DialogTileGrid(
      {super.key, required this.children, this.columns});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: columns == null ? null : (DIALOG_TILE_SIZE * columns!) + (_spacing * (columns! - 1)),
      child: Wrap(
        spacing: _spacing,
        runSpacing: _spacing,
        children: children,
      ),
    );
  }
}
