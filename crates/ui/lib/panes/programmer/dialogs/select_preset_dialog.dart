import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/grid/panel_grid.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/panes/programmer/dialogs/select_preset_type_dialog.dart';

class SelectPresetDialog extends StatelessWidget {
  final PresetType presetType;
  final PresetsState state;

  const SelectPresetDialog(this.presetType, this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Select Preset".i18n,
      onConfirm: () => _newPreset(context),
      padding: false,
      content: Container(
        width: MAX_TILE_DIALOG_WIDTH,
        height: MAX_DIALOG_HEIGHT,
        child: SingleChildScrollView(
          child: PanelGrid(
              children: state
                  .getByPresetType(presetType)
                  .map((preset) => PanelGridTile.idWithText(
                      id: preset.id.id.toString(),
                      text: preset.label ?? "",
                      onTap: () => Navigator.of(context).pop(preset.id)))
                  .toList()),
        ),
      ),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
        PopupAction("New Preset".i18n, () => _newPreset(context))
      ],
    );
  }

  void _newPreset(BuildContext context) {
    Navigator.of(context).pop(presetType);
  }
}
