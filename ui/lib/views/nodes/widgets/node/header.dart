import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../../consts.dart';

class NodeHeader extends StatelessWidget {
  final String name;
  final Node_NodeType type;

  NodeHeader(this.name, this.type);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(INNER_RADIUS))),
        color: getColorForType(type),
      ),
      clipBehavior: Clip.none,
      padding: const EdgeInsets.all(4),
      child: Text(name, style: textTheme.bodyText2),
    );
  }
}
