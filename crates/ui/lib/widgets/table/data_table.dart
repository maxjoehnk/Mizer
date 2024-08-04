import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Row;
import 'package:mizer/api/contracts/ui.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/ui.pb.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

class MizerDataTable extends StatefulWidget {
  final String tableId;
  final List<String> arguments;
  final Function(String)? onTap;
  final Function(String, String)? onTapChild;
  final String? selectedId;
  final String? query;

  const MizerDataTable(
      {super.key,
      required this.tableId,
      this.arguments = const [],
      this.onTap,
      this.onTapChild,
      this.query,
      this.selectedId});

  @override
  State<MizerDataTable> createState() => _MizerDataTableState();
}

class _MizerDataTableState extends State<MizerDataTable> {
  Future<TabularData>? data;
  String? expandedId;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void didUpdateWidget(MizerDataTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tableId != widget.tableId || oldWidget.arguments != widget.arguments) {
      _fetch();
    }
  }

  void _fetch() {
    UiApi api = this.context.read();
    this.data = api.showTable(widget.tableId, widget.arguments);
    this.expandedId = null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.data,
      builder: (context, state) {
        if (state.hasError) {
          return Text("Error: ${state.error}");
        }
        if (!state.hasData) {
          return Container();
        }

        return SingleChildScrollView(
          child: MizerTable(
              columnWidths: {
                0: FixedColumnWidth(40),
              },
              columns: [
                Container(),
                ...state.requireData.columns.map((e) => Text(e))
              ],
              rows: state.requireData.rows
                  .where(this.matchRow)
                  .map((r) {
                    var expanded = r.id == expandedId;
                    List<MizerTableRow> children = [];
                    if (expanded) {
                      children = r.children
                          .map((c) => MizerTableRow(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                cells: [Container(), ...c.cells.map((c) => Text(c))],
                                onTap: widget.onTapChild == null
                                    ? null
                                    : () => widget.onTapChild!(r.id, c.id),
                              ))
                          .toList();
                    }
                    return [
                      MizerTableRow(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          selected: r.id == widget.selectedId,
                          cells: [
                            if (r.children.isNotEmpty)
                              MizerIconButton(
                                onClick: () => setState(() {
                                  if (expanded) {
                                    expandedId = null;
                                  }else {
                                    expandedId = r.id;
                                  }
                                }),
                                icon: expanded ? Icons.arrow_drop_down : Icons.arrow_right,
                                label: "Expand".i18n,
                              ),
                            if (r.children.isEmpty) Container(),
                            ...r.cells.map((c) => Text(c))
                          ],
                          onTap: widget.onTap == null ? null : () => widget.onTap!(r.id)),
                      ...children,
                    ];
                  })
                  .flattened
                  .toList()),
        );
      },
    );
  }

  bool matchRow(Row row) {
    if (widget.query == null || widget.query!.isEmpty) {
      return true;
    }
    var query = widget.query!.toLowerCase();

    return row.cells.any((element) => element.toLowerCase().contains(query));
  }
}
