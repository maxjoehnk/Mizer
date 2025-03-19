import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';

class PropertyGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  PropertyGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: Grey800, borderRadius: BorderRadius.circular(BORDER_RADIUS)),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.centerLeft,
            height: GRID_2_SIZE,
            color: Grey600,
            child: Text(this.title)),
        SizedBox(height: PANEL_GAP_SIZE),
        ...children
            .map((w) => Padding(padding: const EdgeInsets.all(PANEL_GAP_SIZE), child: w))
            .toList(),
        SizedBox(height: PANEL_GAP_SIZE),
      ]),
    );
  }
}
