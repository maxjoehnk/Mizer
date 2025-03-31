import 'package:flutter/material.dart' hide Tab;
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart';
import 'package:mizer/widgets/table/data_table.dart';
import 'package:provider/provider.dart';

class FixtureDefinitionsView extends StatefulWidget {
  const FixtureDefinitionsView({super.key});

  @override
  State<FixtureDefinitionsView> createState() => _FixtureDefinitionsViewState();
}

class _FixtureDefinitionsViewState extends State<FixtureDefinitionsView> {
  String? search = null;
  String? selectedDefinitionId = null;
  String? selectedMode = null;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: PANEL_GAP_SIZE,
      children: [
        Expanded(
          flex: 1,
          child: Panel(
            label: "Fixture Definitions",
            actions: [
              PanelActionModel(
                label: "Reload".i18n,
                onClick: () => context.read<SettingsApi>().reloadFixtureDefinitions(),
              )
            ],
            tabs: [
              Tab(
                label: "Open Fixture Library",
                child: MizerDataTable(
                    tableId: "fixtures/definitions/list/ofl",
                    onTap: (id) => setState(() {
                      selectedDefinitionId = id;
                      selectedMode = null;
                    }),
                    query: search,
                    selectedId: selectedDefinitionId)
              ),
              Tab(
                  label: "GDTF",
                  child: MizerDataTable(
                      tableId: "fixtures/definitions/list/gdtf",
                      onTap: (id) => setState(() {
                        selectedDefinitionId = id;
                        selectedMode = null;
                      }),
                      query: search,
                      selectedId: selectedDefinitionId)
              ),
              Tab(
                  label: "QLC+",
                  child: MizerDataTable(
                      tableId: "fixtures/definitions/list/qlc",
                      onTap: (id) => setState(() {
                        selectedDefinitionId = id;
                        selectedMode = null;
                      }),
                      query: search,
                      selectedId: selectedDefinitionId)
              ),
              Tab(
                  label: "Mizer",
                  child: MizerDataTable(
                      tableId: "fixtures/definitions/list/mizer",
                      onTap: (id) => setState(() {
                        selectedDefinitionId = id;
                        selectedMode = null;
                      }),
                      query: search,
                      selectedId: selectedDefinitionId)
              ),
            ],
            onSearch: (q) => setState(() {
              search = q;
            }),
          ),
        ),
        if (selectedDefinitionId != null)
          Expanded(
            flex: 2,
            child: Panel(
              label: "Fixture Modes",
              child: MizerDataTable(
                  tableId: "fixtures/definitions/modes",
                  arguments: [selectedDefinitionId!],
                  onTap: (id) => setState(() {
                        selectedMode = id;
                      }),
                  selectedId: selectedMode),
            ),
          ),
        if (selectedDefinitionId != null && selectedMode != null)
          Expanded(
              flex: 2,
              child: Panel(
            label: "Fixture Mode",
            padding: false,
            tabs: [
              Tab(
                  label: "Controls",
                  child: MizerDataTable(
                      tableId: "fixtures/definitions/tree",
                      arguments: [selectedDefinitionId!, selectedMode!])),
              Tab(
                  label: "DMX Channels",
                  child: MizerDataTable(
                      tableId: "fixtures/definitions/channels",
                      arguments: [selectedDefinitionId!, selectedMode!]))
            ],
          ))
      ],
    );
  }
}
