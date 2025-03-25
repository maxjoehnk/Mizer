import 'package:flutter/material.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/grid/panel_grid.dart';

import 'select_preset_type_dialog.dart';

const double MAX_DIALOG_WIDTH = 512;
const double MAX_DIALOG_HEIGHT = 512;
const double TILE_SIZE = 96;

class SelectPresetDialog extends StatelessWidget {
  final PresetType presetType;
  final PresetsState state;

  const SelectPresetDialog(this.presetType, this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Select Preset",
      onConfirm: () => _newPreset(context),
      padding: false,
      content: Container(
        width: MAX_DIALOG_WIDTH,
        height: MAX_DIALOG_HEIGHT,
        child: PanelGrid(
            children: state
                .getByPresetType(presetType)
                .map((preset) => PanelGridTile.idWithText(
                    id: preset.id.id.toString(),
                    text: preset.label ?? "",
                    onTap: () => Navigator.of(context).pop(preset.id)))
                .toList()),
      ),
      actions: [
        PopupAction("Cancel", () => Navigator.of(context).pop()),
        PopupAction("New Preset", () => _newPreset(context))
      ],
    );
  }

  void _newPreset(BuildContext context) {
    Navigator.of(context).pop(presetType);
  }
}
