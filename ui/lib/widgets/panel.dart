import 'package:flutter/material.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/widgets/tabs.dart' as tab;
import 'package:provider/provider.dart';

import 'hoverable.dart';

class Panel extends StatefulWidget {
  final String? label;
  final Widget? child;
  final List<tab.Tab>? tabs;
  final List<PanelAction>? actions;
  final Function()? onAdd;
  final bool padding;
  final int? tabIndex;
  final Function(int)? onSelectTab;
  final List<Widget>? trailingHeader;

  bool get canAdd {
    return onAdd != null;
  }

  Panel(
      {this.child,
      this.tabs,
      this.label,
      this.actions,
      this.tabIndex,
      this.onSelectTab,
      this.onAdd,
      this.padding = true,
      this.trailingHeader}) {
    assert(child != null || tabs != null);
  }

  factory Panel.tabs(
      {required List<tab.Tab> tabs,
      String? label,
      List<PanelAction>? actions,
      int? tabIndex,
      Function(int)? onSelectTab,
      Function()? onAdd,
      bool padding = true,
      List<Widget>? trailingHeader}) {
    return Panel(
        tabs: tabs,
        label: label,
        actions: actions,
        tabIndex: tabIndex,
        onSelectTab: onSelectTab,
        onAdd: onAdd,
        padding: padding,
        trailingHeader: trailingHeader);
  }

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    activeIndex = widget.tabIndex ?? 0;
  }

  @override
  void didUpdateWidget(Panel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabIndex == null || widget.tabIndex == oldWidget.tabIndex) {
      return;
    }
    setState(() {
      activeIndex = widget.tabIndex!;
    });
  }

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
          _header(context),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(),
                        clipBehavior: Clip.antiAlias,
                        child: widget.child ?? _activeTab)),
                if (widget.actions != null) PanelActions(actions: widget.actions!)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    if (widget.label == null && widget.tabs == null) {
      return Container();
    }
    return Container(
        color: Colors.grey.shade800,
        height: 32,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.label != null)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                  color: Colors.grey.shade800,
                  child: Text(widget.label!, textAlign: TextAlign.start),
                ),
              if (widget.label != null) Container(width: 8),
              ...(this.widget.tabs ?? [])
                  .asMap()
                  .map((i, e) => MapEntry(
                      i,
                      e.header(
                        this.activeIndex == i,
                        () => _onSelectTab(i),
                      )))
                  .values,
              if (widget.canAdd) tab.AddTabButton(onClick: widget.onAdd!),
              Spacer(),
              ...(widget.trailingHeader ?? [])
            ]));
  }

  Widget? get _activeTab {
    if (widget.tabs?.isEmpty ?? true) {
      return null;
    }
    return Padding(
      padding: widget.padding ? const EdgeInsets.all(8.0) : const EdgeInsets.all(0),
      child: widget.tabs![activeIndex].child,
    );
  }

  void _onSelectTab(int index) {
    if (widget.onSelectTab != null) {
      widget.onSelectTab!(index);
      return;
    }
    setState(() {
      this.activeIndex = index;
    });
  }
}

class PanelAction {
  final String label;
  final Function()? onClick;
  final bool disabled;
  final bool activated;
  final String? hotkeyId;
  final Menu? menu;

  PanelAction(
      {required this.label,
      this.onClick,
      this.disabled = false,
      this.activated = false,
      this.hotkeyId,
      this.menu});
}

class PanelActions extends StatelessWidget {
  final List<PanelAction> actions;

  const PanelActions({required this.actions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var hotkeys = context.read<HotkeyMapping?>();

    return SingleChildScrollView(
      child: Column(
        children: actions.map((a) {
          var hotkey = _getHotkey(hotkeys, a);
          return GestureDetector(
            onSecondaryTapDown: (event) => _openActionMenu(context, a, event.globalPosition),
            onLongPressEnd: (event) => _openActionMenu(context, a, event.globalPosition),
            child: Hoverable(
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
                    Text(a.label,
                        textAlign: TextAlign.center,
                        style: textTheme.subtitle2!.copyWith(fontSize: 11, color: _getColor(a))),
                    if (hotkey != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(hotkey.toCapitalCase(),
                            style:
                                textTheme.bodySmall!.copyWith(color: _getHotkeyColor(a), fontSize: 10)),
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _openActionMenu(BuildContext context, PanelAction action, Offset position) {
    if (action.menu == null || action.disabled) {
      return;
    }
    Platform.of(context).showContextMenu(context: context, menu: action.menu!, position: position);
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
