import 'package:flutter/widgets.dart';
import 'package:mizer/panels/presets/dimmer_presets.dart';
import 'package:mizer/panels/presets/position_presets.dart';
import 'package:mizer/views/fixtures/fixtures_view.dart';
import 'package:mizer/views/layout/layout_view.dart';
import 'package:mizer/views/plan/plan_view.dart';

import 'media/media_list.dart';
import 'media/media_metadata.dart';
import 'media/media_preview.dart';
import 'presets/color_presets.dart';
import 'presets/groups.dart';
import 'presets/shutter_presets.dart';

Map<String, Widget> PanelTypes = {
  "layout": LayoutViewWrapper(),
  "plan": PlanView(),
  "fixtures": FixturesView(),
  "group_list": const GroupsPanel(),
  "dimmer_presets": const DimmerPresetsPanel(),
  "shutter_presets": const ShutterPresetsPanel(),
  "color_presets": const ColorPresetsPanel(),
  "position_presets": const PositionPresetsPanel(),
  "media_list": const MediaListPanel(),
  "media_preview": const MediaPreviewPanel(),
  "media_metadata": const MediaMetadataPanel(),
};

class RegisteredPanel extends StatelessWidget {
  final String panelType;

  const RegisteredPanel({super.key, required this.panelType});

  @override
  Widget build(BuildContext context) {
    return PanelTypes[panelType] ??
           Center(child: Text("Panel type '$panelType' not registered"));
  }
}
