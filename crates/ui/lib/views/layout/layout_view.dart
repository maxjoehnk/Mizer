import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/layout_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/layouts_bloc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/views/layout/dialogs/delete_layout_dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:mizer/widgets/popup/popup_route.dart';
import 'package:mizer/widgets/tabs.dart' as tabs;

import 'add_control_popup.dart';
import 'control.dart';
import 'dialogs/name_layout_dialog.dart';

const double MULTIPLIER = GRID_4_SIZE;
const String MovingNodeIndicatorLayoutId = "MovingNodeIndicator";
const String ResizingNodeIndicatorLayoutId = "ResizingNodeIndicator";

class LayoutViewWrapper extends StatefulWidget {
  @override
  State<LayoutViewWrapper> createState() => _LayoutViewWrapperState();
}

class _LayoutViewWrapperState extends State<LayoutViewWrapper> {
  LayoutsRefPointer? _pointer;

  @override
  void initState() {
    super.initState();
    var layoutsApi = context.read<LayoutsApi>();
    layoutsApi.getLayoutsPointer().then((pointer) {
      setState(() {
        _pointer = pointer;
      });
    });
  }

  @override
  void dispose() {
    _pointer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this._pointer == null) {
      return Container();
    }
    return LayoutView(this._pointer!);
  }
}

class LayoutView extends StatelessWidget {
  final LayoutsRefPointer _pointer;

  LayoutView(this._pointer);

  @override
  Widget build(BuildContext context) {
    var layoutsBloc = context.read<LayoutsBloc>();
    layoutsBloc.add(FetchLayouts());
    return BlocBuilder<LayoutsBloc, LayoutState>(builder: (context, state) {
      log("${state.layouts}", name: "LayoutView");
      context.read<NodesBloc>().add(FetchNodes());
      return HotkeyConfiguration(
        hotkeySelector: (hotkeys) => hotkeys.layouts,
        hotkeyMap: {
          "add_layout": () => _addLayout(context, layoutsBloc),
        },
        child: Panel.tabs(
          label: "Layout".i18n,
          tabIndex: state.tabIndex,
          onSelectTab: (index) => layoutsBloc.add(SelectLayoutTab(tabIndex: index)),
          padding: false,
          tabs: state.layouts
              .map((layout) => tabs.Tab(
                  header: (active, setActive) => ContextMenu(
                      menu: Menu(items: [
                        MenuItem(
                            label: "Rename".i18n,
                            action: () => _onRename(context, layout, layoutsBloc)),
                        MenuItem(
                            label: "Delete".i18n,
                            action: () => _onDelete(context, layout, layoutsBloc)),
                      ]),
                      child: tabs.TabHeader(layout.id, selected: active, onSelect: setActive)),
                  child: ControlLayout(
                    pointer: _pointer,
                    layout: layout,
                  )))
              .toList(),
          onAdd: () => _addLayout(context, layoutsBloc),
        ),
      );
    });
  }

  Future<void> _addLayout(BuildContext context, LayoutsBloc layoutsBloc) {
    return showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) => NameLayoutDialog(),
    ).then((name) => layoutsBloc.add(AddLayout(name: name)));
  }

  void _onDelete(BuildContext context, Layout layout, LayoutsBloc bloc) async {
    bool result = await showDialog(
        context: context, builder: (BuildContext context) => DeleteLayoutDialog(layout: layout));
    if (result) {
      bloc.add(RemoveLayout(id: layout.id));
    }
  }

  void _onRename(BuildContext context, Layout layout, LayoutsBloc bloc) async {
    String? result =
        await showDialog(context: context, builder: (context) => NameLayoutDialog(name: layout.id));
    if (result != null) {
      bloc.add(RenameLayout(id: layout.id, name: result));
    }
  }
}

class ControlLayout extends StatefulWidget {
  final LayoutsRefPointer pointer;
  final Layout layout;

  ControlLayout({required this.pointer, required this.layout});

  @override
  State<ControlLayout> createState() => _ControlLayoutState();
}

class _ControlLayoutState extends State<ControlLayout> {
  LayoutControl? _movingNode;
  Offset? _movingNodePosition;
  LayoutControl? _resizingNode;
  Size? _resizingNodeSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SequencerBloc, SequencerState>(builder: (context, sequences) {
      return BlocBuilder<PresetsBloc, PresetsState>(
        builder: (context, presets) {
          return BlocBuilder<NodesBloc, PipelineState>(builder: (context, nodes) {
            return Container(
              width: 20 * MULTIPLIER,
              height: 15 * MULTIPLIER,
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerHover: (event) {
                  _moveNode(event);
                  _resizeNode(event);
                },
                onPointerDown: (e) {
                  if (_movingNode == null && _resizingNode == null) {
                    return;
                  }
                  _placeNode();
                },
                child: Stack(
                  children: [
                    GestureDetector(
                      onSecondaryTapDown: (details) {
                        LayoutsBloc bloc = context.read();
                        int x = (details.localPosition.dx / MULTIPLIER).floor();
                        int y = (details.localPosition.dy / MULTIPLIER).floor();
                        var position = ControlPosition(x: Int64(x), y: Int64(y));
                        Navigator.of(context).push(MizerPopupRoute(
                            position: details.globalPosition,
                            child: AddControlPopup(
                              nodes: nodes.allNodes.where((node) {
                                var control = widget.layout.controls
                                    .firstWhereOrNull((c) => c.node.path == node.path);

                                return control == null;
                              }).toList(),
                              sequences: sequences.sequences,
                              groups: presets.groups,
                              presets: presets.presets,
                              onCreateControl: (controlType) => bloc.add(AddControl(
                                  layoutId: widget.layout.id,
                                  controlType: controlType,
                                  position: position)),
                              onAddControlForExisting: (node) => bloc.add(AddExistingControl(
                                  layoutId: widget.layout.id, node: node, position: position)),
                              onCreateGroupControl: (group) => bloc.add(AddExistingControl.group(
                                  layoutId: widget.layout.id, groupId: group, position: position)),
                              onCreatePresetControl: (presetId) => bloc.add(
                                  AddExistingControl.preset(
                                      layoutId: widget.layout.id,
                                      presetId: presetId,
                                      position: position)),
                              onCreateSequenceControl: (sequenceId) => bloc.add(
                                  AddExistingControl.sequence(
                                      layoutId: widget.layout.id,
                                      sequenceId: sequenceId,
                                      position: position)),
                            )));
                      },
                    ),
                    _ControlsContainer(
                        pointer: widget.pointer,
                        layout: widget.layout,
                        startMove: _startMove,
                        startResize: _startResize,
                        movingNode: _movingNode,
                        movingNodePosition: _movingNodePosition,
                        resizingNode: _resizingNode,
                        resizingNodeSize: _resizingNodeSize),
                  ],
                ),
              ),
            );
          });
        },
      );
    });
  }

  _startMove(LayoutControl control) {
    setState(() {
      _movingNode = control;
      _movingNodePosition =
          Offset(control.position.x.toDouble(), control.position.y.toDouble()) * MULTIPLIER;
    });
  }

  _moveNode(PointerHoverEvent event) {
    if (_movingNode == null) {
      return;
    }
    setState(() {
      _movingNodePosition = event.localPosition;
    });
  }

  _startResize(LayoutControl control) {
    setState(() {
      _resizingNode = control;
      _resizingNodeSize =
          Size(control.size.width.toDouble(), control.size.height.toDouble()) * MULTIPLIER;
    });
  }

  _resizeNode(PointerHoverEvent event) {
    if (_resizingNode == null) {
      return;
    }
    var corner =
        Offset(_resizingNode!.position.x.toDouble(), _resizingNode!.position.y.toDouble()) *
            MULTIPLIER;
    setState(() {
      _resizingNodeSize = Rect.fromPoints(corner, event.localPosition).size;
    });
  }

  _placeNode() {
    LayoutsBloc bloc = context.read();
    if (_movingNode != null) {
      var position = screenToLayoutPosition(_movingNodePosition!).toControlPosition();
      bloc.add(
          MoveControl(layoutId: widget.layout.id, controlId: _movingNode!.id, position: position));

      setState(() {
        _movingNode = null;
        _movingNodePosition = null;
      });
    }
    if (_resizingNode != null) {
      var size = screenToLayoutSize(_resizingNodeSize!).toControlSize();
      bloc.add(ResizeControl(layoutId: widget.layout.id, controlId: _resizingNode!.id, size: size));

      setState(() {
        _resizingNode = null;
        _resizingNodeSize = null;
      });
    }
  }
}

class _ControlsContainer extends StatelessWidget {
  final LayoutsRefPointer pointer;
  final Layout layout;
  final Function(LayoutControl) startMove;
  final LayoutControl? movingNode;
  final Offset? movingNodePosition;
  final Function(LayoutControl) startResize;
  final LayoutControl? resizingNode;
  final Size? resizingNodeSize;

  const _ControlsContainer(
      {required this.pointer,
      required this.layout,
      required this.startMove,
      required this.startResize,
      this.movingNode,
      this.movingNodePosition,
      this.resizingNode,
      this.resizingNodeSize,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SequencerStateFetcher(builder: (context, sequencerState) {
        return CustomMultiChildLayout(
            delegate: ControlsLayoutDelegate(
                layout, movingNode?.id, movingNodePosition, resizingNode?.id, resizingNodeSize),
            children: [
              if (movingNode != null)
                LayoutId(
                    id: MovingNodeIndicatorLayoutId,
                    child: Container(
                        decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.deepOrange.withAlpha(128),
                          width: 4,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.deepOrange.shade100.withAlpha(10),
                    ))),
              ...layout.controls.map((c) => LayoutId(
                  id: c.id,
                  child: LayoutControlView(
                    pointer,
                    layout.id,
                    c,
                    sequencerState,
                    onMove: () => startMove(c),
                    onResize: () => startResize(c),
                  ))),
              if (resizingNode != null)
                LayoutId(
                    id: ResizingNodeIndicatorLayoutId,
                    child: Container(
                        decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.deepOrange.withAlpha(128),
                          width: 4,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.deepOrange.shade100.withAlpha(10),
                    ))),
            ]);
      }),
    );
  }
}

class ControlsLayoutDelegate extends MultiChildLayoutDelegate {
  final Layout layout;
  final String? movingControlId;
  final Offset? movingControlPosition;
  final String? resizingControlId;
  final Size? resizingControlSize;

  ControlsLayoutDelegate(this.layout, this.movingControlId, this.movingControlPosition,
      this.resizingControlId, this.resizingControlSize);

  @override
  void performLayout(Size size) {
    for (var control in layout.controls) {
      var controlSize =
          Size(control.size.width.toDouble(), control.size.height.toDouble()) * MULTIPLIER + (Offset(control.size.width.toDouble() - 1, control.size.height.toDouble() - 1) * GRID_GAP_SIZE);
      layoutChild(control.id, BoxConstraints.tight(controlSize));
      var controlOffset = movingControlId == control.id
          ? movingControlPosition!
          : Offset(control.position.x.toDouble(), control.position.y.toDouble()) * MULTIPLIER;

      controlOffset += Offset(control.position.x.toDouble(), control.position.y.toDouble()) * GRID_GAP_SIZE;
      positionChild(control.id, controlOffset);
      if (movingControlId != null && movingControlId == control.id) {
        layoutChild(MovingNodeIndicatorLayoutId, BoxConstraints.tight(controlSize));
        positionChild(MovingNodeIndicatorLayoutId,
            screenToLayoutPosition(movingControlPosition!) * MULTIPLIER + screenToLayoutPosition(movingControlPosition!) * GRID_GAP_SIZE);
      }
      if (resizingControlId != null && resizingControlId == control.id) {
        var size = screenToLayoutSize(resizingControlSize!);
        layoutChild(ResizingNodeIndicatorLayoutId,
            BoxConstraints.tight(size * MULTIPLIER + (Offset(size.width.toDouble() - 1, size.height.toDouble() - 1) * GRID_GAP_SIZE)));
        positionChild(ResizingNodeIndicatorLayoutId, controlOffset);
      }
    }
  }

  @override
  bool shouldRelayout(covariant ControlsLayoutDelegate oldDelegate) {
    return oldDelegate.movingControlPosition != movingControlPosition ||
        oldDelegate.movingControlId != movingControlId ||
        oldDelegate.layout != layout ||
        oldDelegate.resizingControlSize != resizingControlSize ||
        oldDelegate.resizingControlId != resizingControlId;
  }
}

Offset screenToLayoutPosition(Offset offset) {
  double x = (offset.dx / MULTIPLIER).round().clamp(0, 100).toDouble();
  double y = (offset.dy / MULTIPLIER).round().clamp(0, 100).toDouble();

  return Offset(x, y);
}

Size screenToLayoutSize(Size size) {
  double width = (size.width / MULTIPLIER).round().clamp(1, 100).toDouble();
  double height = (size.height / MULTIPLIER).round().clamp(1, 100).toDouble();

  return Size(width, height);
}

class SequencerStateFetcher extends StatefulWidget {
  final Widget Function(BuildContext, Map<int, SequenceState>) builder;

  const SequencerStateFetcher({required this.builder, Key? key}) : super(key: key);

  @override
  _SequencerStateFetcherState createState() => _SequencerStateFetcherState();
}

class _SequencerStateFetcherState extends State<SequencerStateFetcher>
    with SingleTickerProviderStateMixin {
  SequencerPointer? _pointer;
  Map<int, SequenceState> sequenceStates = {};
  Ticker? ticker;

  @override
  void initState() {
    super.initState();
    var sequencerApi = context.read<SequencerApi>();
    sequencerApi.getSequencerPointer().then((pointer) => setState(() {
          _pointer = pointer;
          ticker = this.createTicker((elapsed) {
            setState(() {
              sequenceStates = _pointer!.readState();
            });
          });
          ticker!.start();
        }));
  }

  @override
  void dispose() {
    _pointer?.dispose();
    ticker?.stop(canceled: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, sequenceStates);
  }
}
