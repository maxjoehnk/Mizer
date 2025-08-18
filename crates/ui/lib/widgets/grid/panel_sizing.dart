import 'package:flutter/widgets.dart';
import 'package:mizer/consts.dart';

class PanelSizing extends StatelessWidget {
  final double? columns;
  final double? rows;
  final Widget child;

  const PanelSizing({ this.columns, this.rows, required this.child, super.key });

  @override
  Widget build(BuildContext context) {
    var width = columns == null ? null : (columns! * GRID_4_SIZE) + (columns! - 1) * GRID_GAP_SIZE + 2 * GRID_GAP_SIZE;
    var height = rows == null ? null : rows! * GRID_4_SIZE + (rows! - 1) * GRID_GAP_SIZE + PANEL_HEADER_HEIGHT + 2 * GRID_GAP_SIZE;

    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}
