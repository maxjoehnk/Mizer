import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/state/layouts_bloc.dart';

import 'control.dart';

const double MULTIPLIER = 75;

class LayoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<LayoutsBloc>().add(LayoutsEvent.Fetch);
    return BlocBuilder<LayoutsBloc, Layouts>(builder: (context, layouts) {
      if (layouts.layouts.isEmpty) {
        return Container();
      }
      log("${layouts.layouts}");
      return Container(
        width: 20 * MULTIPLIER,
        height: 20 * MULTIPLIER,
        child: CustomMultiChildLayout(
            delegate: ControlsLayoutDelegate(layouts.layouts[0]),
            children: layouts
                .layouts[0]
                .controls
                .map((e) => LayoutId(id: e.node, child: LayoutControlView(e)))
                .toList()),
      );
    });
  }
}

class ControlsLayoutDelegate extends MultiChildLayoutDelegate {
  final Layout layout;

  ControlsLayoutDelegate(this.layout);

  @override
  void performLayout(Size size) {
    for (var control in layout.controls) {
      var controlSize = Size(control.size.width.toDouble(), control.size.height.toDouble()) * MULTIPLIER;
      layoutChild(control.node, BoxConstraints.tight(controlSize));
      var controlOffset = Offset(control.position.x.toDouble(), control.position.y.toDouble()) * MULTIPLIER;
      positionChild(control.node, controlOffset);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
