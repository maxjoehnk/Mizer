import 'package:flutter/material.dart';
import 'package:mizer/available_nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../../consts.dart';

class NodeHeader extends StatelessWidget {
  final String path;
  final String name;
  final NodeCategory category;
  final bool collapsed;

  NodeHeader(this.path, this.name, this.category, {this.collapsed = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: collapsed
                ? BorderRadius.circular(INNER_RADIUS)
                : BorderRadius.vertical(top: Radius.circular(INNER_RADIUS))),
        color: CATEGORY_COLORS[category] ?? Colors.black,
      ),
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: textTheme.bodyMedium),
          Text(path, style: textTheme.bodySmall),
        ],
      ),
    );
  }
}
