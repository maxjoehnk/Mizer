import 'package:flutter/material.dart';

class PropertyGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  PropertyGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration:
          BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(padding: EdgeInsets.all(4), color: Colors.grey.shade700, child: Text(this.title)),
        SizedBox(height: 2),
        ...children
            .map((w) =>
                Padding(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), child: w))
            .toList(),
        SizedBox(height: 2),
      ]),
    );
  }
}
