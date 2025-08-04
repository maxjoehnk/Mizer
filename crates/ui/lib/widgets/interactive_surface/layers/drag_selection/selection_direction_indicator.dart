import 'package:flutter/widgets.dart';

import 'package:mizer/widgets/interactive_surface/layers/drag_selection/selection_state.dart';

class SelectionDirectionIndicator extends StatelessWidget {
  final SelectionDirection direction;

  const SelectionDirectionIndicator(this.direction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      left: 8,
      child: Text(direction.toString()),
    );
  }
}

