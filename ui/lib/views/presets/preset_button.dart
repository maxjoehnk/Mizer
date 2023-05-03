import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/mixins/programmer_mixin.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/inputs/decoration.dart';
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
    return PresetButton(
      child: Container(
        width: 48,
        height: 48,
        child: Center(child: Icon(MdiIcons.spotlightBeam)),
      ),
      group: widget.group,
      active: programmerState.activeGroups.contains(widget.group.id),
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  final Preset preset;

  const ColorButton({required this.color, required this.preset, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PresetButton(
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(24)),
        ),
        preset: preset);
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
