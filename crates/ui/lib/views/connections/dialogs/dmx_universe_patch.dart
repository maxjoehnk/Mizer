import 'package:flutter/material.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/hoverable.dart';

const double TILE_SIZE = 48;

const double ACTIVE_PATCH_SIZE = 12;

class DmxUniversePatch extends StatefulWidget {
  final int inputUniverses = 10;
  final int outputUniverses = 10;

  DmxUniversePatch({super.key}) {}

  @override
  State<DmxUniversePatch> createState() => _DmxUniversePatchState();
}

class _DmxUniversePatchState extends State<DmxUniversePatch> {
  final Map<int, Set<int>> mappings = {};

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= widget.inputUniverses; i++) {
      mappings[i] = [i].toSet();
    }
  }

  final BoxDecoration decoration =
      BoxDecoration(border: Border.all(color: Colors.grey.shade700), color: Colors.grey.shade900);

  final BoxDecoration fieldDecoration =
      BoxDecoration(border: Border.all(color: Colors.grey.shade700), color: Colors.grey.shade800);

  @override
  Widget build(BuildContext context) {
    final int rows = widget.inputUniverses + 1;
    final int columns = widget.outputUniverses + 1;
    return ActionDialog(
        title: "DMX Patch",
        content: Container(
          width: TILE_SIZE * columns,
          height: TILE_SIZE * rows,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
          ),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns),
              itemBuilder: (context, i) {
                var x = i % columns;
                var y = i ~/ columns;

                var isHeaderColumn = x == 0;
                var isHeaderRow = y == (rows - 1);

                var inputUniverse = y + 1;
                var outputUniverse = x;

                if (isHeaderColumn && isHeaderRow) {
                  return Container(
                    width: TILE_SIZE,
                    height: TILE_SIZE,
                    decoration: decoration,
                  );
                }
                if (isHeaderColumn) {
                  return Container(
                    width: TILE_SIZE,
                    height: TILE_SIZE,
                    decoration: decoration,
                    child: Center(child: Text("$inputUniverse")),
                  );
                }
                if (isHeaderRow) {
                  return Container(
                    width: TILE_SIZE,
                    height: TILE_SIZE,
                    decoration: decoration,
                    child: Center(child: Text("$outputUniverse")),
                  );
                }
                var isActive = mappings[inputUniverse]?.contains(outputUniverse) ?? false;
                return Hoverable(
                    onTap: () {
                      setState(() {
                        if (isActive) {
                          mappings[inputUniverse]?.remove(outputUniverse);
                        } else {
                          mappings[inputUniverse]?.add(outputUniverse);
                        }
                      });
                    },
                    builder: (isHovering) => Container(
                      width: TILE_SIZE,
                      height: TILE_SIZE,
                      decoration: BoxDecoration(
                        border: decoration.border,
                        color: isHovering
                            ? Colors.grey.shade700
                            : isActive
                                ? Colors.grey.shade900
                                : Colors.grey.shade800,
                      ),
                    )
                );
              }),
        ));
  }
}
