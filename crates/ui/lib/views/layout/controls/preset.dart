import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/mixins/programmer_mixin.dart';
import 'package:mizer/protos/layouts.pb.dart' show ControlSize;
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/widgets/inputs/decoration.dart';

class PresetControl extends StatefulWidget {
  final String? label;
  final Color? color;
  final Node node;
  final ControlSize size;

  const PresetControl(
      {required this.label, this.color, required this.node, required this.size, Key? key})
      : super(key: key);

  @override
  State<PresetControl> createState() => _PresetControlState();
}

class _PresetControlState extends State<PresetControl>
    with SingleTickerProviderStateMixin, ProgrammerStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetsBloc, PresetsState>(builder: (context, state) {
      return Container(
        decoration: ControlDecoration(color: widget.color),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _callPreset(),
            child: Center(
                child: Text(_getLabel(state),
                    textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall)),
          ),
        ),
      );
    });
  }

  PresetId get _presetId {
    return widget.node.config.presetConfig.presetId;
  }

  _callPreset() {
    var programmerApi = context.read<ProgrammerApi>();
    programmerApi.callPreset(_presetId);
  }

  String _getLabel(PresetsState state) {
    if (widget.label != null && widget.label!.isNotEmpty) {
      return widget.label!;
    }

    return _getPresets(state).firstWhereOrNull((p) => p.id == _presetId)?.label ?? "";
  }

  List<Preset> _getPresets(PresetsState state) {
    var presets = state.presets.intensities.toList();
    presets.addAll(state.presets.colors);
    presets.addAll(state.presets.shutters);
    presets.addAll(state.presets.positions);

    return presets;
  }
}
