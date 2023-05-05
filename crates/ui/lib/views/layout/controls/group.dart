import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/mixins/programmer_mixin.dart';
import 'package:mizer/protos/layouts.pb.dart' show ControlSize;
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/widgets/inputs/decoration.dart';

class GroupControl extends StatefulWidget {
  final String? label;
  final Color? color;
  final Node node;
  final ControlSize size;

  const GroupControl(
      {required this.label, this.color, required this.node, required this.size, Key? key})
      : super(key: key);

  @override
  State<GroupControl> createState() => _GroupControlState();
}

class _GroupControlState extends State<GroupControl>
    with SingleTickerProviderStateMixin, ProgrammerStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetsBloc, PresetsState>(builder: (context, state) {
      return Container(
        decoration: ControlDecoration(
            color: widget.color, highlight: programmerState.activeGroups.contains(_groupId)),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _callGroup(),
            child: Center(
                child: Text(_getLabel(state),
                    textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall)),
          ),
        ),
      );
    });
  }

  int get _groupId {
    return widget.node.config.groupConfig.groupId;
  }

  _callGroup() {
    var programmerApi = context.read<ProgrammerApi>();
    programmerApi.selectGroup(_groupId);
  }

  String _getLabel(PresetsState state) {
    if (widget.label != null && widget.label!.isNotEmpty) {
      return widget.label!;
    }

    return state.groups.firstWhere((g) => g.id == _groupId).name;
  }
}
