import 'package:flutter/material.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:provider/provider.dart';

import 'hoverable.dart';

class Panel extends StatelessWidget {
  final String? label;
  final Widget child;
  final List<PanelAction>? actions;

  Panel({required this.child, this.label, this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade800, width: 2)),
      margin: const EdgeInsets.all(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (label != null)
            Container(
                color: Colors.grey.shade800,
                padding: const EdgeInsets.all(2),
                child: Text(label!, textAlign: TextAlign.start)),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: child),
                if (actions != null) PanelActions(actions: actions!)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PanelAction {
  final String label;
  final Function()? onClick;
  final bool disabled;
  final bool activated;
  final String? hotkeyId;

  PanelAction({required this.label, this.onClick, this.disabled = false, this.activated = false, this.hotkeyId});
}

class PanelActions extends StatelessWidget {
  final List<PanelAction> actions;

  const PanelActions({required this.actions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var hotkeys = context.read<HotkeyMapping?>();

    return Column(
      children: actions
          .map((a) {
            var hotkey = _getHotkey(hotkeys, a);
            return Hoverable(
                disabled: a.disabled || a.onClick == null,
                onTap: a.onClick,
                builder: (hovered) => Container(
                  color: _getBackground(a, hovered),
                  height: 64,
                  width: 64,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(a.label, textAlign: TextAlign.center, style: textTheme.subtitle2!.copyWith(fontSize: 11, color: _getColor(a))),
                      if (hotkey != null) Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(hotkey.toCapitalCase(), style: textTheme.bodySmall!.copyWith(color: _getHotkeyColor(a), fontSize: 10)),
                      ),
                    ],
                  ),
                ),
              );
          })
          .toList(),
    );
  }

  String? _getHotkey(HotkeyMapping? hotkeys, PanelAction action) {
    if (hotkeys?.mappings == null) {
      return null;
    }
    return hotkeys!.mappings[action.hotkeyId];
  }

  Color _getBackground(PanelAction action, bool hovered) {
    if (action.disabled == true) {
      return Colors.grey.shade800.withAlpha(128);
    }
    if (action.activated || hovered) {
      return Colors.grey.shade700;
    }
    return Colors.grey.shade800;
  }

  Color _getColor(PanelAction action) {
    if (action.disabled == true) {
      return Colors.white54;
    }
    return Colors.white;
  }

  Color _getHotkeyColor(PanelAction action) {
    if (action.disabled == true) {
      return Colors.white24;
    }
    return Colors.white54;
  }
}
