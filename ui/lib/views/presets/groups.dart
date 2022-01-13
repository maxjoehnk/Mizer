import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/inputs/decoration.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:provider/provider.dart';

class GroupsPanel extends StatelessWidget {
  final List<Group> groups;

  const GroupsPanel(this.groups, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Panel(
      label: "Groups",
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: groups.map((group) => GroupControl(group)).toList()),
      ),
    ));
  }
}

class GroupControl extends StatelessWidget {
  final Group group;

  const GroupControl(this.group, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var programmerApi = context.read<ProgrammerApi>();
    return Hoverable(
        onTap: () => programmerApi.selectGroup(group.id),
        builder: (hovered) => Container(
              width: 64,
              height: 64,
              decoration: ControlDecoration(highlight: hovered),
              child: Center(child: Text(group.name, textAlign: TextAlign.center)),
            ));
  }
}
