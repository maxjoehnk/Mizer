import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/mixins/programmer_mixin.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/mappings.pb.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/plans_bloc.dart';
import 'package:mizer/views/mappings/midi_mapping.dart';
import 'package:mizer/views/plan/dialogs/delete_plan_dialog.dart';
import 'package:mizer/widgets/controls/button.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:mizer/widgets/tabs.dart' as tabs;

import 'dialogs/name_plan_dialog.dart';
import 'plan_layout.dart';

const double fieldSize = 24;

class PlanView extends StatefulWidget {
  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView>
    with SingleTickerProviderStateMixin, ProgrammerStateMixin {
  bool _setupMode = false;
  Uint8List? _placingImage;
  bool _creatingScreen = false;

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
                      plan: plan,
                      programmerState: programmerState,
                      setupMode: _setupMode,
                      placingImage: _placingImage,
                      cancelPlacing: () => setState(() => _placingImage = null),
                      placeImage: _placeImage,
                      creatingScreen: _creatingScreen,
                      onAddScreen: (rect) {
                        plansBloc.add(AddScreen(
                            x: rect.left / fieldSize,
                            y: rect.top / fieldSize,
                            width: rect.width / fieldSize,
                            height: rect.height / fieldSize));
                        setState(() => _creatingScreen = false);
                      },
                    )),
                    if (_setupMode) AlignToolbar(),
                  ])))
              .toList(),
          onAdd: () => _addPlan(context, plansBloc),
          actions: [
            PanelActionModel(
                hotkeyId: "highlight",
                label: "Highlight",
                onClick: _highlight,
                activated: programmerState.highlight,
                menu: Menu(items: [
                  MenuItem(
                      label: "Add Midi Mapping", action: () => _addMidiMappingForHighlight(context))
                ])),
            PanelActionModel(
                hotkeyId: "clear",
                label: "Clear",
                onClick: _clear,
                menu: Menu(items: [
                  MenuItem(
                      label: "Add Midi Mapping", action: () => _addMidiMappingForClear(context))
                ])),
            PanelActionModel(label: "Setup", activated: _setupMode, onClick: _setup),
            if (_setupMode)
              PanelActionModel(
                  label: "Place Fixture Selection",
                  onClick: () => _placeFixtureSelection(plansBloc)),
            if (_setupMode)
              PanelActionModel(label: "Add Image", onClick: () => _addImage(plansBloc)),
            if (_setupMode)
              PanelActionModel(label: "Add Screen", onClick: () => setState(() => _creatingScreen = true)),
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
        context: context, builder: (BuildContext context) => DeletePlanDialog(plan: plan));
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
    programmerApi.highlight(!(programmerState.highlight));
  }

  void _clear() {
    context.read<ProgrammerApi>().clear();
  }

  Future _placeFixtureSelection(PlansBloc bloc) async {
    bloc.add(PlaceFixtureSelection());
  }

  _addImage(PlansBloc bloc) async {
    const imageGroup = XTypeGroup(label: 'Images', extensions: ['jpg', 'jpeg', 'png']);
    XFile? image = await openFile(acceptedTypeGroups: [imageGroup]);
    if (image == null) {
      return;
    }
    Uint8List buffer = await image.readAsBytes();
    setState(() {
      _placingImage = buffer;
    });
  }

  _placeImage(Offset offset, Size size) async {
    PlansBloc bloc = context.read();
    bloc.add(AddImage(
        x: offset.dx,
        y: offset.dy,
        transparency: 1,
        width: size.width,
        height: size.height,
        data: _placingImage!));
    setState(() {
      _placingImage = null;
    });
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
  final TextEditingController rotationController = TextEditingController(text: "0");

  AlignFixturesRequest_AlignDirection direction = AlignFixturesRequest_AlignDirection.LEFT_TO_RIGHT;

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
                    setState(() => direction = AlignFixturesRequest_AlignDirection.LEFT_TO_RIGHT))),
        SizedBox(
            width: 48,
            child: MizerIconButton(
                icon: MdiIcons.alignVerticalTop,
                label: "Top to Bottom",
                onClick: () =>
                    setState(() => direction = AlignFixturesRequest_AlignDirection.TOP_TO_BOTTOM))),
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
        Spacer(),
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: rotationController,
            decoration: InputDecoration(label: Text("Rotation"), filled: true),
          ),
        ),
        MizerButton(child: Text("Transform"), onClick: () => _transform()),
        Spacer(),
        MizerButton(child: Text("Square"), onClick: () => _spread(SpreadFixturesRequest_SpreadGeometry.SQUARE)),
        MizerButton(child: Text("Triangle"), onClick: () => _spread(SpreadFixturesRequest_SpreadGeometry.TRIANGLE)),
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

  _transform() {
    PlansBloc bloc = context.read();
    int rotation = int.parse(rotationController.text);

    bloc.add(TransformFixtures(rotation: rotation));
  }

  _spread(SpreadFixturesRequest_SpreadGeometry geometry) {
    PlansBloc bloc = context.read();
    bloc.add(SpreadFixtures(geometry: geometry));
  }
}
