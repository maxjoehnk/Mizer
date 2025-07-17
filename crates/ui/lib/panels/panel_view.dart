import 'package:flutter/widgets.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/panels/panel_registry.dart';
import 'package:mizer/protos/ui.pb.dart' hide Row;

class PanelView extends StatelessWidget {
  final ViewChild viewChild;

  const PanelView({super.key, required this.viewChild});

  @override
  Widget build(BuildContext context) {
    if (viewChild.hasGroup()) {
      if (viewChild.group.direction == PanelGroup_Direction.DIRECTION_VERTICAL) {
        return Column(
          spacing: PANEL_GAP_SIZE,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: viewChild.group.children.map((child) {
            var widget = PanelView(viewChild: child);
            if (child.height.hasPixels()) {
              return SizedBox(height: child.height.pixels.pixels.toDouble(), child: widget);
            }
            if (child.height.hasFlex()) {
              return Flexible(flex: child.height.flex.flex, child: widget);
            }
            if (child.height.hasFill()) {
              return Expanded(child: widget);
            }
            if (child.height.hasGridItems()) {
              return SizedBox(height: child.height.gridItems.count.toDouble() * GRID_4_SIZE, child: widget);
            }
            return widget;
          }).toList(),
        );
      } else {
        return Row(
          spacing: PANEL_GAP_SIZE,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: viewChild.group.children.map((child) {
            var widget = PanelView(viewChild: child);
            if (child.width.hasPixels()) {
              return SizedBox(width: child.width.pixels.pixels.toDouble(), child: widget);
            }
            if (child.width.hasFlex()) {
              return Flexible(flex: child.width.flex.flex, child: widget);
            }
            if (child.width.hasFill()) {
              return Expanded(child: widget);
            }
            if (child.width.hasGridItems()) {
              return SizedBox(width: child.width.gridItems.count.toDouble() * GRID_4_SIZE);
            }
            return widget;
          }).toList(),
        );
      }
    }

    return RegisteredPanel(panelType: viewChild.panel.panelType);
  }
}
