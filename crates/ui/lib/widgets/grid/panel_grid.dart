import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';

class PanelGrid extends StatelessWidget {
  final List<Widget> children;

  const PanelGrid({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(GRID_GAP_SIZE),
      child: Wrap(
        spacing: GRID_GAP_SIZE,
        runSpacing: GRID_GAP_SIZE,
        children: children,
      ),
    );
  }
}
