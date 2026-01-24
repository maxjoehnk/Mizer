import 'package:collection/collection.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/path_field.dart';
import 'package:mizer/widgets/controls/button.dart';
import 'package:mizer/i18n.dart';

class PathsSetting extends StatelessWidget {
  final String label;
  final List<String> paths;
  final bool resetToDefault;
  final Function() onResetToDefault;
  final Function(List<String>) onUpdate;

  const PathsSetting({required this.paths, required this.onUpdate, super.key, required this.label, this.resetToDefault = false, required this.onResetToDefault});

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 4, mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label),
        ),
        SizedBox(width: 8),
        if (resetToDefault) MizerIconButton(icon: Icons.settings_backup_restore, onClick: onResetToDefault, label: "Reset to default".i18n)
      ]),
      ...paths.mapEnumerated((path, i) {
        return PathField(
            value: path,
            onUpdate: (p) {
              onUpdate(paths.mapEnumerated((p, j) => i == j ? p : p).toList());
            },
            actions: [
              FieldAction(
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                  onTap: () => onUpdate(paths.whereIndexed((j, _) => i != j).toList()))
            ]);
      }),
      MizerButton(
          child: Text("Add Path".i18n),
          onClick: () async {
            final path = await getDirectoryPath();
            if (path == null) {
              return;
            }
            onUpdate([...paths, path]);
          })
    ]);
  }
}
