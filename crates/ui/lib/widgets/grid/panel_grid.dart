import 'package:flutter/material.dart';

class PanelGrid extends StatelessWidget {
  final List<Widget> children;

  const PanelGrid({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(1),
      child: Wrap(
        spacing: 1,
        runSpacing: 1,
        children: children,
      ),
    );
  }
}
