import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';

const double _padding = 1;

class PanelGrid extends StatelessWidget {
  final List<Widget> children;

  const PanelGrid({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: GridView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(1),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: GRID_MAIN_SIZE,
          mainAxisExtent: GRID_MAIN_SIZE,
          crossAxisSpacing: _padding,
          mainAxisSpacing: _padding,
          childAspectRatio: 1,
        ),
        children: children,
      ),
    );
  }
}
