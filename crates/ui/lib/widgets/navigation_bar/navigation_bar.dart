import 'dart:math' as Math;

import 'package:flutter/material.dart' hide View;
import 'package:mizer/actions/actions.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/high_contrast_text.dart';

class NavigationBar extends StatelessWidget {
  final List<Widget> children;

  NavigationBar({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: NAVIGATION_BAR_SIZE,
        child: LayoutBuilder(
          builder: (context, constraints) {
            var items = (constraints.maxHeight / (GRID_4_SIZE + 1)).ceil();
            return ListView.separated(
              itemCount: Math.max(children.length, items),
              itemBuilder: (context, index) {
                if (index >= children.length) {
                  return PanelGridTile.empty();
                }
                return children[index];
              },
              separatorBuilder: (context, index) => SizedBox(height: 1),
            );
          }
        ));
  }
}

class NavigationBarItem extends StatelessWidget {
  final bool selected;
  final Function() onSelect;
  final IconData icon;
  final String label;
  final String? hotkeyLabel;

  const NavigationBarItem(
      {super.key,
      required this.onSelect,
      required this.icon,
      required this.label,
      this.hotkeyLabel,
      this.selected = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var color = selected ? theme.colorScheme.secondary : theme.hintColor;

    return PanelGridTile(
      onTap: onSelect,
      selected: selected,
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
                HighContrastText(label, textAlign: TextAlign.center, autoSize: AutoSize(
                  minFontSize: 12
                )),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          if (hotkeyLabel != null)
            Align(
                alignment: Alignment.topRight,
                child: Text(hotkeyLabel!.toCapitalCase(),
                    style: textTheme.bodySmall!.copyWith(fontSize: 12))),
        ],
      ),
    );
  }
}

class Route {
  final WidgetFunction view;
  final IconData icon;
  final String label;
  final View viewKey;
  final bool show;

  Route(this.view, this.icon, this.label, this.viewKey, {this.show = true});
}

typedef WidgetFunction = Widget Function();

class NavigationRouteItem extends StatelessWidget {
  final Route route;
  final bool selected;
  final void Function() onSelect;
  final Map<String, String> hotkeys;

  NavigationRouteItem(this.route, this.selected, this.onSelect, this.hotkeys);

  @override
  Widget build(BuildContext context) {
    return NavigationBarItem(
        onSelect: onSelect,
        icon: route.icon,
        label: route.label,
        selected: selected,
        hotkeyLabel: hotkeyLabel);
  }

  String? get hotkeyLabel {
    return hotkeys[route.viewKey.toHotkeyString()];
  }
}
