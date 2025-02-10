import 'package:flutter/material.dart' hide View;
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/actions/actions.dart';

class NavigationBar extends StatelessWidget {
  final List<Widget> children;

  NavigationBar({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade800,
        width: NAVIGATION_BAR_SIZE,
        child: ListView(children: children));
  }
}

class NavigationBarItem extends StatelessWidget {
  final bool selected;
  final Function() onSelect;
  final IconData icon;
  final String label;
  final String? hotkeyLabel;

  const NavigationBarItem({super.key, required this.onSelect, required this.icon, required this.label, this.hotkeyLabel, this.selected = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var color = selected ? theme.colorScheme.secondary : theme.hintColor;

    return Hoverable(
        onTap: onSelect,
        builder: (hovering) => Container(
          height: NAVIGATION_BAR_SIZE,
          color: getBackgroundColor(hovering),
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
                    Text(label, textAlign: TextAlign.center,
                        style: textTheme.titleSmall!.copyWith(color: color, fontSize: 10)),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              if (hotkeyLabel != null)
                Align(
                    alignment: Alignment.topRight,
                    child: Text(hotkeyLabel!.toCapitalCase(),
                        style: textTheme.bodySmall!.copyWith(fontSize: 9))),
            ],
          ),
        )
    );
  }

  Color? getBackgroundColor(bool hovering) {
    if (selected) {
      return Colors.black26;
    }
    if (hovering) {
      return Colors.black12;
    }
    return null;
  }
}

class Route {
  final WidgetFunction view;
  final IconData icon;
  final String label;
  final View viewKey;

  Route(this.view, this.icon, this.label, this.viewKey);
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
    return NavigationBarItem(onSelect: onSelect, icon: route.icon, label: route.label, selected: selected, hotkeyLabel: hotkeyLabel);
  }

  String? get hotkeyLabel {
    return hotkeys[route.viewKey.toHotkeyString()];
  }
}
