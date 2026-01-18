import 'package:flutter/material.dart';
import 'package:mizer/available_nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

import 'package:mizer/views/nodes/consts.dart';

class NodeHeader extends StatelessWidget {
  final String path;
  final String name;
  final NodeCategory category;

  NodeHeader(this.path, this.name, this.category);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(INNER_RADIUS))),
        color: CATEGORY_COLORS[category] ?? Colors.grey.shade800,
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
