import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/mixins/programmer_mixin.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/patch/dialogs/group_name_dialog.dart';
import 'package:mizer/views/presets/dialogs/preset_name_dialog.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/inputs/decoration.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:provider/provider.dart';

class EffectButton extends StatelessWidget {
  final Effect effect;

  const EffectButton({required this.effect, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PresetButton(
        child: Container(
          width: 48,
          height: 48,
          child: Center(child: Icon(MdiIcons.sineWave, size: 32)),
        ),
        effect: effect);
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
      child: PresetButton(
        child: Container(
          width: 48,
          height: 48,
          child: Center(child: Icon(MdiIcons.spotlightBeam)),
        ),
        group: widget.group,
        active: programmerState.activeGroups.contains(widget.group.id),
      ),
    );
  }

  void _renameGroup() async {
    var name = await showDialog(
        context: context, builder: (context) => GroupNameDialog(name: widget.group.name));
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

class ColorButton extends StatelessWidget {
  final Color color;
  final Preset preset;

  const ColorButton({required this.color, required this.preset, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContextMenu(
      menu: Menu(items: [
        MenuItem(label: "Rename", action: () => _renamePreset(context)),
        MenuItem(label: "Delete", action: () => _deletePreset(context)),
      ]),
      child: PresetButton(
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(24)),
          ),
          preset: preset),
    );
  }

  void _renamePreset(BuildContext context) async {
    var name = await showDialog(
        context: context, builder: (context) => PresetNameDialog(name: preset.label));
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

class PositionButton extends StatelessWidget {
  final Preset preset;
  final double? pan;
  final double? tilt;

  const PositionButton({required this.pan, required this.tilt, required this.preset, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContextMenu(
      menu: Menu(items: [
        MenuItem(label: "Rename", action: () => _renamePreset(context)),
        MenuItem(label: "Delete", action: () => _deletePreset(context)),
      ]),
      child: PresetButton(
          child: Container(
            margin: tilt == null ? EdgeInsets.symmetric(vertical: 12) : EdgeInsets.all(0),
            width: pan == null ? 24 : 48,
            height: tilt == null ? 24 : 48,
            padding: const EdgeInsets.all(4),
            decoration:
                BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)),
            child: CustomPaint(painter: PositionPainter(pan: pan, tilt: tilt)),
          ),
          preset: preset),
    );
  }

  void _renamePreset(BuildContext context) async {
    var name = await showDialog(
        context: context, builder: (context) => PresetNameDialog(name: preset.label));
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

class PositionPainter extends CustomPainter {
  final double? pan;
  final double? tilt;

  PositionPainter({required this.pan, required this.tilt});

  @override
  void paint(Canvas canvas, Size size) {
    var x = size.width * (pan ?? 0.5);
    var y = size.height * (tilt ?? 0.5);

    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(x, y), 4, paint);
  }

  @override
  bool shouldRepaint(covariant PositionPainter oldDelegate) {
    return pan != oldDelegate.pan || tilt != oldDelegate.tilt;
  }
}

class PresetButton extends StatelessWidget {
  final Widget child;
  final bool? active;
  final Group? group;
  final Preset? preset;
  final Effect? effect;

  PresetButton({required this.child, this.active, this.preset, this.effect, this.group, Key? key})
      : super(key: key) {
    assert(effect != null || preset != null || group != null);
  }

  @override
  Widget build(BuildContext context) {
    var programmerApi = context.read<ProgrammerApi>();
    var textTheme = Theme.of(context).textTheme;

    return Hoverable(onTap: () {
      if (preset != null) {
        programmerApi.callPreset(preset!.id);
      }
      if (effect != null) {
        programmerApi.callEffect(effect!.id);
      }
      if (group != null) {
        programmerApi.selectGroup(group!.id);
      }
    }, builder: (hovered) {
      return Container(
        width: 72,
        height: 80,
        decoration:
            ControlDecoration(color: hovered ? Colors.grey.shade900 : Colors.black, hover: hovered),
        child: Stack(
          children: [
            if (active == true)
              Align(
                  child: Container(
                    height: 30,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.shade900,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                  ),
                  alignment: Alignment.bottomCenter),
            Container(
              padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
              alignment: Alignment.topCenter,
              child: child,
            ),
            Align(
                child: Text(label,
                    style: textTheme.bodySmall,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    maxLines: 2),
                alignment: Alignment.bottomCenter),
            Align(child: Text(id, style: textTheme.bodySmall), alignment: Alignment.topLeft),
          ],
        ),
      );
    });
  }

  String get label {
    return group?.name ?? effect?.name ?? preset!.label;
  }

  String get id {
    if (effect != null) {
      return "E${effect!.id}";
    }
    if (group != null) {
      return "G${group!.id}";
    }
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
    return "Missing Implementation for PresetButton Id";
  }
}
