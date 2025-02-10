import 'package:flutter/widgets.dart';
import 'package:mizer/consts.dart';

class PanelSizing extends StatelessWidget {
  final double? columns;
  final double? rows;
  final Widget child;

  const PanelSizing({ this.columns, this.rows, required this.child, super.key });

  @override
  Widget build(BuildContext context) {
    var width = columns == null ? null : (columns! * GRID_MAIN_SIZE) + (columns! - 1);
    var height = rows == null ? null : rows! * GRID_MAIN_SIZE + (rows! - 1);

    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}
