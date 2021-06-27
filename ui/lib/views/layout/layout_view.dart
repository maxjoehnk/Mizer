import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/state/layouts_bloc.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:mizer/widgets/tabs.dart' as tabs;

import 'control.dart';

const double MULTIPLIER = 75;

class LayoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var layoutsBloc = context.read<LayoutsBloc>();
    layoutsBloc.add(FetchLayouts());
    return BlocBuilder<LayoutsBloc, Layouts>(builder: (context, layouts) {
      log("${layouts.layouts}", name: "LayoutView");
      return tabs.Tabs(
        children: layouts.layouts
            .map((layout) => tabs.Tab(
                header: (active, setActive) => ContextMenu(
                    menu: Menu(items: [
                      MenuItem(
                          label: "Rename", action: () => _onRename(context, layout, layoutsBloc)),
                      MenuItem(
                          label: "Delete", action: () => _onDelete(context, layout, layoutsBloc)),
                    ]),
                    child: tabs.TabHeader(layout.id, selected: active, onSelect: setActive)),
                child: ControlLayout(
                  layout: layout,
                )))
            .toList(),
        onAdd: () => showDialog(
          context: context,
          useRootNavigator: false,
          builder: (_) => NameLayoutDialog(),
        ).then((name) => layoutsBloc.add(AddLayout(name: name))),
      );
    });
  }

  void _onDelete(BuildContext context, Layout layout, LayoutsBloc bloc) async {
    bool result = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Delete Layout"),
              content: SingleChildScrollView(
                child: Text("Delete Layout ${layout.id}?"),
              ),
              actions: [
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  autofocus: true,
                  child: Text("Delete"),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ));
    if (result) {
      bloc.add(RemoveLayout(id: layout.id));
    }
  }

  void _onRename(BuildContext context, Layout layout, LayoutsBloc bloc) async {
    String result =
        await showDialog(context: context, builder: (context) => NameLayoutDialog(name: layout.id));
    if (result != null) {
      bloc.add(RenameLayout(id: layout.id, name: result));
    }
  }
}

class NameLayoutDialog extends StatelessWidget {
  final String name;
  final TextEditingController nameController;

  NameLayoutDialog({this.name, Key key})
      : nameController = TextEditingController(text: name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(name != null ? "Rename Layout" : "Add Layout"),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(nameController.text),
              child: Text(name != null ? "Rename" : "Add"))
        ],
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Name"),
        ));
  }
}

class ControlLayout extends StatelessWidget {
  final Layout layout;

  ControlLayout({this.layout});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20 * MULTIPLIER,
      height: 10 * MULTIPLIER,
      child: CustomMultiChildLayout(
          delegate: ControlsLayoutDelegate(layout),
          children: layout.controls
              .map((e) => LayoutId(id: e.node, child: LayoutControlView(e)))
              .toList()),
    );
  }
}

class ControlsLayoutDelegate extends MultiChildLayoutDelegate {
  final Layout layout;

  ControlsLayoutDelegate(this.layout);

  @override
  void performLayout(Size size) {
    for (var control in layout.controls) {
      var controlSize =
          Size(control.size.width.toDouble(), control.size.height.toDouble()) * MULTIPLIER;
      layoutChild(control.node, BoxConstraints.tight(controlSize));
      var controlOffset =
          Offset(control.position.x.toDouble(), control.position.y.toDouble()) * MULTIPLIER;
      positionChild(control.node, controlOffset);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
