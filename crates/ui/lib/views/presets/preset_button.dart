import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/dialogs/name_dialog.dart';
import 'package:mizer/mixins/programmer_mixin.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/high_contrast_text.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:provider/provider.dart';

class EffectButton extends StatelessWidget {
  final Effect effect;

  const EffectButton({required this.effect, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PresetButton.effect(child: Container(), effect: effect);
  }
}

class GroupButton extends StatefulWidget {
  final Group group;

  const GroupButton({required this.group, Key? key}) : super(key: key);

  @override
  State<GroupButton> createState() => _GroupButtonState();
}

class _GroupButtonState extends State<GroupButton>
    with SingleTickerProviderStateMixin, ProgrammerStateMixin {
  @override
  Widget build(BuildContext context) {
    return ContextMenu(
      menu: Menu(items: [
        MenuItem(label: "Rename", action: () => _renameGroup()),
        MenuItem(label: "Delete", action: () => _deleteGroup()),
      ]),
      child: PresetButton.group(
        child: Container(),
        group: widget.group,
        active: programmerState.activeGroups.contains(widget.group.id),
        onTap: (BuildContext context) {
          var programmerApi = context.read<ProgrammerApi>();
          programmerApi.selectGroup(widget.group.id);
        },
      ),
    );
  }

  void _renameGroup() async {
    var name = await context.showRenameDialog(name: widget.group.name);
    if (name == null) {
      return;
    }
    PresetsBloc state = context.read();
    state.add(RenameGroup(widget.group.id, name));
  }

  void _deleteGroup() {
    PresetsBloc state = context.read();
    state.add(DeleteGroup(widget.group.id));
  }
}

class CallPresetButton extends StatelessWidget {
  final Widget child;
  final Preset preset;
  final void Function()? onTap;

  const CallPresetButton({ required this.preset, required this.child, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ContextMenu(
      menu: Menu(items: [
        MenuItem(label: "Rename", action: () => _renamePreset(context)),
        MenuItem(label: "Delete", action: () => _deletePreset(context)),
      ]),
      child: PresetButton.preset(
        child: child,
        preset: preset,
        onTap: onTap,
      ),
    );
  }

  void _renamePreset(BuildContext context) async {
    var name = await showDialog(
        context: context, builder: (context) => NameDialog(name: preset.label));
    if (name == null) {
      return;
    }
    PresetsBloc state = context.read();
    state.add(RenamePreset(preset.id, name));
  }

  void _deletePreset(BuildContext context) async {
    PresetsBloc state = context.read();
    state.add(DeletePreset(preset.id));
  }
}

class PresetButton extends StatelessWidget {
  final Widget child;
  final bool? active;
  final String label;
  final Group? group;
  final Preset? preset;
  final Effect? effect;
  late final void Function(BuildContext context) onTap;

  PresetButton(
      {required this.child,
      required this.label,
      required void Function() onTap,
      this.active,
      Key? key})
      : effect = null,
        group = null,
        preset = null,
        super(key: key) {
    this.onTap = (context) => onTap();
  }

  PresetButton.preset(
      {required this.child, required this.preset, this.active, void Function()? onTap, Key? key})
      : label = preset!.label,
        effect = null,
        group = null {
    this.onTap = (BuildContext context) {
      var programmerApi = context.read<ProgrammerApi>();
      programmerApi.callPreset(preset!.id);
      onTap?.call();
    };
  }

  PresetButton.effect({required this.child, required this.effect, this.active, Key? key})
      : label = effect!.name,
        preset = null,
        group = null {
    this.onTap = (BuildContext context) {
      var programmerApi = context.read<ProgrammerApi>();
      programmerApi.callEffect(effect!.id);
    };
  }

  PresetButton.group(
      {required this.child, required this.group, required this.onTap, this.active, Key? key})
      : label = group!.name,
        preset = null,
        effect = null {}

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return PanelGridTile(
      onTap: () => this.onTap(context),
      active: active ?? false,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Container(width: GRID_3_SIZE, height: GRID_3_SIZE, child: child),
            ),
            Align(
              alignment: Alignment.center,
              child: HighContrastText(label, textAlign: TextAlign.center),
            ),
            if (id != null)
              Align(child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text(id!, style: textTheme.bodySmall),
                  ), alignment: Alignment.topLeft),
                if (target != null)
                  Align(child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Text(target!, style: textTheme.bodySmall),
                  ), alignment: Alignment.topRight),
          ],
        ),
      ),
    );
  }

  String? get target {
    if (preset?.target == PresetTarget.PRESET_TARGET_UNIVERSAL) {
      return "U";
    }
    if (preset?.target == PresetTarget.PRESET_TARGET_SELECTIVE) {
      return "S";
    }

    return null;
  }

  String? get id {
    if (effect != null) {
      return "E${effect!.id}";
    }
    if (group != null) {
      return "G${group!.id}";
    }
    if (preset != null) {
      if (preset!.id.type == PresetId_PresetType.COLOR) {
        return "C${preset!.id.id}";
      }
      if (preset!.id.type == PresetId_PresetType.INTENSITY) {
        // Panel is actually called Dimmer
        return "D${preset!.id.id}";
      }
      if (preset!.id.type == PresetId_PresetType.SHUTTER) {
        return "S${preset!.id.id}";
      }
      if (preset!.id.type == PresetId_PresetType.POSITION) {
        return "P${preset!.id.id}";
      }
    }
    return null;
  }
}
