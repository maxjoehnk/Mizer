import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/state/layouts_bloc.dart';
import 'package:mizer/widgets/tabs.dart' as tabs;

import 'control.dart';

const double MULTIPLIER = 75;

class LayoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var layoutsBloc = context.read<LayoutsBloc>();
    layoutsBloc.add(FetchLayouts());
    return BlocBuilder<LayoutsBloc, Layouts>(builder: (context, layouts) {
      log("${layouts.layouts}");
      return tabs.Tabs(
        children: layouts.layouts
            .map((l) => tabs.Tab(
                label: l.id,
                child: ControlLayout(
                  layout: l,
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
}

class NameLayoutDialog extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  NameLayoutDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Add Layout"),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(nameController.text), child: Text("Add"))
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
