import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/ui.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/hotkey_formatter.dart';
import 'package:mizer/widgets/tabs.dart' as tab;
import 'package:mizer/widgets/text_field_focus.dart';
import 'package:provider/provider.dart';

import 'hoverable.dart';

class Panel extends StatefulWidget {
  final String? label;
  final Widget? child;
  final List<tab.Tab>? tabs;
  final List<PanelActionModel>? actions;
  final Function()? onAdd;
  final bool padding;
  final int? tabIndex;
  final Function(int)? onSelectTab;
  final List<Widget>? trailingHeader;
  final Function(String)? onSearch;

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
      this.trailingHeader,
      this.onSearch}) {
    assert(child != null || tabs != null);
  }

  factory Panel.tabs(
      {required List<tab.Tab> tabs,
      String? label,
      List<PanelActionModel>? actions,
      int? tabIndex,
      Function(int)? onSelectTab,
      Function()? onAdd,
      bool padding = true,
      List<Widget>? trailingHeader,
      Function(String)? onSearch}) {
    return Panel(
        tabs: tabs,
        label: label,
        actions: actions,
        tabIndex: tabIndex,
        onSelectTab: onSelectTab,
        onAdd: onAdd,
        padding: padding,
        trailingHeader: trailingHeader,
        onSearch: onSearch);
  }

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  int activeIndex = 0;
  bool searchExpanded = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    activeIndex = widget.tabIndex ?? 0;
    searchController.addListener(() => widget.onSearch!(searchController.text));
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
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
        color: Colors.grey.shade800,
        height: PANEL_HEADER_HEIGHT,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.label != null)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                  color: Colors.grey.shade800,
                  child: Text(widget.label!, textAlign: TextAlign.start, style: textTheme.titleMedium),
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
              ...(widget.trailingHeader ?? []),
              if (widget.onSearch != null)
                Expanded(
                  child: Container(
                    color: searchExpanded ? Colors.black12 : null,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (searchExpanded)
                          Expanded(
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 200),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: TextFieldFocus(
                                      child: TextField(
                                        controller: searchController,
                                        autofocus: true,
                                      ),
                                    ),
                                  ))),
                        MizerIconButton(
                            icon: Icons.search,
                            label: "Search",
                            onClick: () => setState(() {
                                  this.searchExpanded = !this.searchExpanded;
                                  if (!this.searchExpanded) {
                                    this.searchController.clear();
                                  }
                                })),
                      ],
                    ),
                  ),
                )
            ]));
  }

  Widget? get _activeTab {
    if (widget.tabs?.isEmpty ?? true) {
      return null;
    }
    if (activeIndex >= widget.tabs!.length) {
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

class PanelActionModel {
  final String label;
  final Function()? onClick;
  final String? command;
  final bool disabled;
  final bool activated;
  final String? hotkeyId;
  final Menu? menu;

  PanelActionModel(
      {required this.label,
      this.onClick,
      this.command,
      this.disabled = false,
      this.activated = false,
      this.hotkeyId,
      this.menu});
}

class PanelActions extends StatelessWidget {
  final List<PanelActionModel> actions;

  const PanelActions({required this.actions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey.shade800,
        child: Column(
          children: actions.map((a) => PanelAction(action: a)).toList(),
        ),
      ),
    );
  }
}

class PanelAction extends StatelessWidget {
  final PanelActionModel action;
  final HotkeyMapping? hotkeys;
  final double width;
  final double height;

  const PanelAction(
      {required this.action, this.hotkeys, this.width = PANEL_ACTION_SIZE, this.height = PANEL_ACTION_SIZE, super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var hotkey = _getHotkey(context);
    bool hasAction = action.onClick != null || action.command != null;
    return GestureDetector(
      onSecondaryTapDown: (event) => _openActionMenu(context, event.globalPosition),
      onLongPressEnd: (event) => _openActionMenu(context, event.globalPosition),
      child: Hoverable(
        disabled: action.disabled || !hasAction,
        onTap: hasAction ? () {
          if (action.onClick != null) {
            action.onClick!();
          }
          if (action.command != null) {
            context.read<UiApi>().commandLineExecute(action.command!);
          }
        } : null,
        builder: (hovered) => Container(
          color: _getBackground(hovered),
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(action.label,
                  textAlign: TextAlign.center,
                  style: textTheme.titleSmall!.copyWith(fontSize: 11, color: _getColor())),
              if (hotkey != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(formatHotkey(hotkey),
                      style: textTheme.bodySmall!.copyWith(color: _getHotkeyColor(), fontSize: 10)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _openActionMenu(BuildContext context, Offset position) {
    if (action.menu == null || action.disabled) {
      return;
    }
    Platform.of(context).showContextMenu(context: context, menu: action.menu!, position: position);
  }

  String? _getHotkey(BuildContext context) {
    var hotkeys = context.read<HotkeyMapping?>();
    if (hotkeys?.mappings == null) {
      return null;
    }
    return hotkeys!.mappings[action.hotkeyId];
  }

  Color _getBackground(bool hovered) {
    if (action.disabled == true) {
      return Colors.black12;
    }
    if (action.activated || hovered) {
      return Colors.white10;
    }
    return Colors.transparent;
  }

  Color _getColor() {
    if (action.disabled == true) {
      return Colors.white54;
    }
    return Colors.white;
  }

  Color _getHotkeyColor() {
    if (action.disabled == true) {
      return Colors.white24;
    }
    return Colors.white54;
  }
}
