import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/presets/preset_button.dart';
import 'package:mizer/views/presets/preset_group.dart';

class GroupsPanel extends StatelessWidget {
  const GroupsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetsBloc, PresetsState>(builder: (context, state) {
      return PresetGroup(
          label: "Groups",
          child: PresetButtonList(
              fill: true,
              children: state.groups.map((group) => GroupButton(group: group)).toList()));
    });
  }
}
