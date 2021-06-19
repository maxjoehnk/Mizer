import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../consts.dart';

class NodeHeader extends StatelessWidget {
  final String name;

  NodeHeader(this.name);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(INNER_RADIUS))),
        color: Colors.green,
      ),
      clipBehavior: Clip.none,
      padding: const EdgeInsets.all(4),
      child: Text(name, style: textTheme.bodyText2),
    );
  }
}
