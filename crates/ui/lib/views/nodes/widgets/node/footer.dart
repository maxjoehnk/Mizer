import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:mizer/widgets/hoverable.dart';

import '../../consts.dart';
import 'tabs.dart';

class NodeFooter extends StatelessWidget {
  final Function(NodeTab) onSelectTab;
  final NodeTab selectedTab;
  final Node node;
  final List<CustomNodeTab> tabs;

  const NodeFooter(
      {required this.selectedTab,
      required this.onSelectTab,
      required this.node,
      required this.tabs,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(INNER_RADIUS)),
      ),
      height: 24,
      child: Row(children: [
        _tab(context, MdiIcons.tuneVariant, NodeTab.Ports),
        if (node.preview != Node_NodePreviewType.NONE) _tab(context, MdiIcons.eye, NodeTab.Preview),
        ...tabs.map((t) => _tab(context, t.icon, t.tab)),
        Spacer(),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(node.details.nodeTypeName, style: textTheme.bodySmall))
      ]),
    );
  }

  Widget _tab(BuildContext context, IconData icon, NodeTab display) {
    var selected = display == selectedTab;

    return Hoverable(
      onTap: () => onSelectTab(display),
      builder: (hovered) {
        var color = selected ? Theme.of(context).colorScheme.secondary : Colors.white54;
        var background =
            selected ? Colors.black26 : (hovered ? Colors.black12 : Colors.transparent);

        return Container(
            padding: const EdgeInsets.all(4),
            color: background,
            child: Icon(icon, size: 16, color: color));
      },
    );
  }
}
