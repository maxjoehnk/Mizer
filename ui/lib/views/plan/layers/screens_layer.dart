import 'package:flutter/material.dart';
import 'package:mizer/protos/plans.pb.dart';

const double fieldSize = 24;

class PlansScreenLayer extends StatelessWidget {
  final Plan plan;

  const PlansScreenLayer({required this.plan, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
        delegate: PlanScreensLayoutDelegate(plan), children: _screens);
  }

  List<Widget> get _screens {
    return plan.screens.map((s) {
      return LayoutId(
          id: "screen-${s.id}",
          child: Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                      strokeAlign: StrokeAlign.center,
                      style: BorderStyle.solid,
                    ))),
          ));
    }).toList();
  }
}

class PlanScreensLayoutDelegate extends MultiChildLayoutDelegate {
  final Plan plan;

  PlanScreensLayoutDelegate(this.plan);

  @override
  void performLayout(Size size) {
    for (var screen in plan.screens) {
      var screenId = screen.id;
      var size = Size(screen.width * fieldSize, screen.height * fieldSize);
      layoutChild(screenId, BoxConstraints.tight(size));
      var offset = _convertScreenToScreenPosition(screen);
      positionChild(screenId, offset);
    }
  }

  @override
  bool shouldRelayout(covariant PlanScreensLayoutDelegate oldDelegate) {
    return plan.screens != oldDelegate.plan.screens;
  }
}

Offset _convertScreenToScreenPosition(PlanScreen screen) {
  return Offset(screen.x.toDouble(), screen.y.toDouble()) * fieldSize;
}
