import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PropertyGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  PropertyGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
          padding: EdgeInsets.all(4),
          color: Colors.black.withOpacity(0.2),
          child: Text(this.title)),
      ...children.map((w) => Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: w)).toList(),
    ]);
  }
}
