import 'dart:math' as Math;

import 'package:flutter/material.dart' hide View;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/icons.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/navigation_bloc.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/high_contrast_text.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HotkeyMapping mapping = context.watch();

    return Container(
        width: NAVIGATION_BAR_SIZE,
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, navigationState) {
            return LayoutBuilder(builder: (context, constraints) {
              var items = (constraints.maxHeight / (GRID_4_SIZE + 1)).ceil();
              return ListView.separated(
                itemCount: Math.max(navigationState.sidebar.length, items),
                itemBuilder: (context, index) {
                  if (index >= navigationState.sidebar.length) {
                    return PanelGridTile.empty();
                  }
                  var view = navigationState.sidebar[index];
                  var selected = navigationState.isActive(view);
                  var hotkeyLabel = mapping.mappings['view_${index + 1}'];

                  return NavigationBarItem(
                      selected: selected,
                      label: view.title,
                      hotkeyLabel: hotkeyLabel,
                      icon: MizerIcons[view.icon] ?? Icons.square_outlined,
                      onSelect: () => context.openView(view));
                },
                separatorBuilder: (context, index) => SizedBox(height: 1),
              );
            });
          },
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
                HighContrastText(label,
                    textAlign: TextAlign.center, autoSize: AutoSize(minFontSize: 12)),
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
