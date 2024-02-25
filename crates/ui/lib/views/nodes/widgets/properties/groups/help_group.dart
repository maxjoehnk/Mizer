import 'package:change_case/change_case.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/widgets/properties/groups/property_group.dart';

class HelpGroup extends StatelessWidget {
  final String? nodeType;
  final String? hoveredSetting;

  const HelpGroup({super.key, this.nodeType, this.hoveredSetting});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return PropertyGroup(title: "Help", children: [
      BlocBuilder<NodesBloc, PipelineState>(
        builder: (context, state) {
          var node = state.availableNodes.firstWhereOrNull((n) => n.type == nodeType);
          var text = node?.description;
          if (hoveredSetting != null) {
            String settingId = hoveredSetting!.toSnakeCase();
            text = node?.settings.firstWhereOrNull((element) => element.name == settingId)?.description ?? text;
          }
          return Text(text ?? "", style: textTheme.bodySmall);
        },
      )
    ]);
  }
}
