import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/ffi/programmer.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/mappings.pb.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/plans_bloc.dart';
import 'package:mizer/views/mappings/midi_mapping.dart';
import 'package:mizer/widgets/controls/button.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:mizer/widgets/tabs.dart' as tabs;

import 'dialogs/name_layout_dialog.dart';
import 'plan_layout.dart';

const double fieldSize = 24;

class PlanView extends StatefulWidget {
  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> with SingleTickerProviderStateMixin {
  ProgrammerStatePointer? _programmerPointer;
  Ticker? _ticker;
  ProgrammerState? _programmerState;
  bool _setupMode = false;

  @override
  void initState() {
    super.initState();
    ProgrammerApi programmerApi = context.read();
    programmerApi.getProgrammerPointer().then((pointer) {
      if (pointer == null) {
        return;
      }
      setState(() {
        _programmerPointer = pointer;
      });
      _ticker = createTicker((elapsed) {
        setState(() => _programmerState = pointer.readState());
      });
      _ticker!.start();
    });
  }

  @override
  void dispose() {
    _programmerPointer?.dispose();
    _ticker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PlansBloc plansBloc = context.read();
    return BlocBuilder<PlansBloc, PlansState>(builder: (context, state) {
      return HotkeyConfiguration(
        hotkeySelector: (hotkeys) => hotkeys.plan,
        hotkeyMap: {
          "highlight": _highlight,
          "clear": _clear,
        },
        child: Panel.tabs(
          label: "2D Plan",
          tabIndex: state.tabIndex,
          onSelectTab: (index) => plansBloc.add(SelectPlanTab(index)),
          padding: false,
          tabs: state.plans
              .map((plan) => tabs.Tab(
                  header: (active, setActive) => ContextMenu(
                      menu: Menu(items: [
                        MenuItem(
                            label: "Rename", action: () => _onRename(context, plan, plansBloc)),
                        MenuItem(
                            label: "Delete", action: () => _onDelete(context, plan, plansBloc)),
                      ]),
                      child: tabs.TabHeader(plan.name, selected: active, onSelect: setActive)),
                  child: Column(children: [
                    Expanded(
                        child: PlanLayout(
                            plan: plan, programmerState: _programmerState, setupMode: _setupMode)),
                    if (_setupMode) AlignToolbar(),
                  ])))
              .toList(),
          onAdd: () => _addPlan(context, plansBloc),
          actions: [
            PanelAction(
                hotkeyId: "highlight",
                label: "Highlight",
                onClick: _highlight,
                activated: _programmerState?.highlight ?? false,
                menu: Menu(items: [
                  MenuItem(
                      label: "Add Midi Mapping", action: () => _addMidiMappingForHighlight(context))
                ])),
            PanelAction(
                hotkeyId: "clear",
                label: "Clear",
                onClick: _clear,
                menu: Menu(items: [
                  MenuItem(
                      label: "Add Midi Mapping", action: () => _addMidiMappingForClear(context))
                ])),
            PanelAction(
                label: "Place Fixture Selection", onClick: () => _placeFixtureSelection(plansBloc)),
            PanelAction(label: "Setup", activated: _setupMode, onClick: _setup),
          ],
        ),
      );
    });
  }

  Future<void> _addPlan(BuildContext context, PlansBloc plansBloc) {
    return showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) => NamePlanDialog(),
    ).then((name) => plansBloc.add(AddPlan(name: name)));
  }

  void _onDelete(BuildContext context, Plan plan, PlansBloc bloc) async {
    bool result = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Delete Plan"),
              content: SingleChildScrollView(
                child: Text("Delete Plan ${plan.name}?"),
              ),
              actions: [
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  autofocus: true,
                  child: Text("Delete"),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ));
    if (result) {
      bloc.add(RemovePlan(id: plan.name));
    }
  }

  void _onRename(BuildContext context, Plan plan, PlansBloc bloc) async {
    String? result =
        await showDialog(context: context, builder: (context) => NamePlanDialog(name: plan.name));
    if (result != null) {
      bloc.add(RenamePlan(id: plan.name, name: result));
    }
  }

  void _highlight() {
    ProgrammerApi programmerApi = context.read();
    programmerApi.highlight(!(_programmerState?.highlight ?? false));
  }

  void _clear() {
    context.read<ProgrammerApi>().clear();
  }

  Future _placeFixtureSelection(PlansBloc bloc) async {
    bloc.add(PlaceFixtureSelection());
  }

  void _setup() {
    _setupMode = !_setupMode;
  }

  Future<void> _addMidiMappingForHighlight(BuildContext context) async {
    var request = MappingRequest(
      programmerHighlight: ProgrammerHighlightAction(),
    );
    addMidiMapping(context, "Add MIDI Mapping for Programmer Highlight", request);
  }

  Future<void> _addMidiMappingForClear(BuildContext context) async {
    var request = MappingRequest(
      programmerClear: ProgrammerClearAction(),
    );
    addMidiMapping(context, "Add MIDI Mapping for Programmer Clear", request);
  }
}

class AlignToolbar extends StatefulWidget {
  const AlignToolbar({Key? key}) : super(key: key);

  @override
  State<AlignToolbar> createState() => _AlignToolbarState();
}

class _AlignToolbarState extends State<AlignToolbar> {
  final TextEditingController groupsController = TextEditingController(text: "1");
  final TextEditingController rowGapController = TextEditingController(text: "0");
  final TextEditingController columnGapController = TextEditingController(text: "0");

  AlignFixturesRequest_AlignDirection direction = AlignFixturesRequest_AlignDirection.LeftToRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Colors.grey.shade800,
      child: Row(children: [
        SizedBox(
            width: 48,
            child: MizerIconButton(
                icon: MdiIcons.alignHorizontalLeft,
                label: "Left to Right",
                onClick: () =>
                    setState(() => direction = AlignFixturesRequest_AlignDirection.LeftToRight))),
        SizedBox(
            width: 48,
            child: MizerIconButton(
                icon: MdiIcons.alignVerticalTop,
                label: "Top to Bottom",
                onClick: () =>
                    setState(() => direction = AlignFixturesRequest_AlignDirection.TopToBottom))),
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: groupsController,
            decoration: InputDecoration(label: Text("Groups"), filled: true),
          ),
        ),
        Container(width: 8),
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: rowGapController,
            decoration: InputDecoration(label: Text("Row Gap"), filled: true),
          ),
        ),
        Container(width: 8),
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: columnGapController,
            decoration: InputDecoration(label: Text("Column Gap"), filled: true),
          ),
        ),
        MizerButton(child: Text("Apply"), onClick: () => _align()),
      ]),
    );
  }

  _align() {
    PlansBloc bloc = context.read();
    int groups = int.parse(groupsController.text);
    int rowGap = int.parse(rowGapController.text);
    int columnGap = int.parse(columnGapController.text);

    bloc.add(
        AlignFixtures(direction: direction, groups: groups, rowGap: rowGap, columnGap: columnGap));
  }
}
