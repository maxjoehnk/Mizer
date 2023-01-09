import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/layouts_bloc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:mizer/widgets/popup/popup_route.dart';
import 'package:mizer/widgets/tabs.dart' as tabs;

import 'add_control_popup.dart';
import 'control.dart';

const double MULTIPLIER = 75;
const String MovingNodeIndicatorLayoutId = "MovingNodeIndicator";

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
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Delete Layout".i18n),
              content: SingleChildScrollView(
                child: Text("Delete Layout ${layout.id}?".i18n),
              ),
              actions: [
                TextButton(
                  child: Text("Cancel".i18n),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  autofocus: true,
                  child: Text("Delete".i18n),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ));
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

class NameLayoutDialog extends StatelessWidget {
  final String? name;
  final TextEditingController nameController;

  NameLayoutDialog({this.name, Key? key})
      : nameController = TextEditingController(text: name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(name != null ? "Rename Layout".i18n : "Add Layout".i18n),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(nameController.text),
              child: Text(name != null ? "Rename".i18n : "Add".i18n))
        ],
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Name"),
          onSubmitted: (text) => Navigator.of(context).pop(text),
        ));
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SequencerBloc, SequencerState>(builder: (context, sequences) {
      return BlocBuilder<NodesBloc, Nodes>(builder: (context, nodes) {
        return Container(
          width: 20 * MULTIPLIER,
          height: 15 * MULTIPLIER,
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerHover: (event) {
              if (_movingNode == null) {
                return;
              }
              setState(() {
                _movingNodePosition = _movingNodePosition! + event.localDelta;
              });
            },
            onPointerDown: (e) {
              if (_movingNode == null) {
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
                                  .firstWhereOrNull((c) => c.node == node.path);

                              return control == null;
                            }).toList(),
                            sequences: sequences.sequences,
                            onCreateControl: (nodeType) => bloc.add(AddControl(
                                layoutId: widget.layout.id,
                                nodeType: nodeType,
                                position: position)),
                            onAddControlForExisting: (node) => bloc.add(AddExistingControl(
                                layoutId: widget.layout.id, node: node, position: position)))));
                  },
                ),
                _ControlsContainer(
                    pointer: widget.pointer,
                    layout: widget.layout,
                    startMove: _startMove,
                    movingNode: _movingNode,
                    movingNodePosition: _movingNodePosition),
              ],
            ),
          ),
        );
      });
    });
  }

  _startMove(LayoutControl control) {
    setState(() {
      _movingNode = control;
      _movingNodePosition =
          Offset(control.position.x.toDouble(), control.position.y.toDouble()) * MULTIPLIER;
    });
  }

  _placeNode() {
    LayoutsBloc bloc = context.read();
    int x = (_movingNodePosition!.dx / MULTIPLIER).floor().clamp(0, 100);
    int y = (_movingNodePosition!.dy / MULTIPLIER).floor().clamp(0, 100);
    var position = ControlPosition(x: Int64(x), y: Int64(y));
    bloc.add(
        MoveControl(layoutId: widget.layout.id, controlId: _movingNode!.node, position: position));

    setState(() {
      _movingNode = null;
      _movingNodePosition = null;
    });
  }
}

class _ControlsContainer extends StatelessWidget {
  final LayoutsRefPointer pointer;
  final Layout layout;
  final LayoutControl? movingNode;
  final Offset? movingNodePosition;
  final Function(LayoutControl) startMove;

  const _ControlsContainer(
      {required this.pointer,
        required this.layout,
      required this.startMove,
      this.movingNode,
      this.movingNodePosition,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SequencerStateFetcher(builder: (context, sequencerState) {
      return CustomMultiChildLayout(
          delegate: ControlsLayoutDelegate(layout, movingNode?.node, movingNodePosition),
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
            ...layout.controls.map((e) => LayoutId(
                id: e.node,
                child: LayoutControlView(pointer, layout.id, e, sequencerState, () => startMove(e)))),
          ]);
    });
  }
}

class ControlsLayoutDelegate extends MultiChildLayoutDelegate {
  final Layout layout;
  final String? movingNode;
  final Offset? movingNodePosition;

  ControlsLayoutDelegate(this.layout, this.movingNode, this.movingNodePosition);

  @override
  void performLayout(Size size) {
    for (var control in layout.controls) {
      var controlSize =
          Size(control.size.width.toDouble(), control.size.height.toDouble()) * MULTIPLIER;
      layoutChild(control.node, BoxConstraints.tight(controlSize));
      var controlOffset = movingNode == control.node
          ? movingNodePosition!
          : Offset(control.position.x.toDouble(), control.position.y.toDouble()) * MULTIPLIER;
      positionChild(control.node, controlOffset);
      if (movingNode != null && movingNode == control.node) {
        layoutChild(MovingNodeIndicatorLayoutId, BoxConstraints.tight(controlSize));
        double x = (movingNodePosition!.dx / MULTIPLIER).floor().clamp(0, 100).toDouble();
        double y = (movingNodePosition!.dy / MULTIPLIER).floor().clamp(0, 100).toDouble();
        var position = Offset(x, y) * MULTIPLIER;
        positionChild(MovingNodeIndicatorLayoutId, position);
      }
    }
  }

  @override
  bool shouldRelayout(covariant ControlsLayoutDelegate oldDelegate) {
    return oldDelegate.movingNodePosition != movingNodePosition ||
        oldDelegate.movingNode != movingNode ||
        oldDelegate.layout != layout;
  }
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
