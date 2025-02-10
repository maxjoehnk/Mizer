import 'package:flutter/widgets.dart';
import 'package:mizer/consts.dart';

class PanelSizing extends StatelessWidget {
  final double? columns;
  final double? rows;
  final Widget child;

  const PanelSizing({ this.columns, this.rows, required this.child, super.key });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: columns == null ? null : columns! * GRID_MAIN_SIZE,
      height: rows == null ? null : rows! * GRID_MAIN_SIZE,
      child: child,
    );
  }
}
