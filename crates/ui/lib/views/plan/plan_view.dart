import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/mixins/programmer_mixin.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/mappings.pb.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/plans_bloc.dart';
import 'package:mizer/views/mappings/midi_mapping.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/number_field.dart';
import 'package:mizer/views/plan/dialogs/delete_plan_dialog.dart';
import 'package:mizer/widgets/hoverable.dart';
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
  int groups = 1;
  int rowGap = 0;
  int columnGap = 0;
  int rotation = 0;

  AlignFixturesRequest_AlignDirection direction = AlignFixturesRequest_AlignDirection.LEFT_TO_RIGHT;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GRID_2_SIZE,
      color: Grey800,
      child: Row(children: [
        PanelToolbarButton.icon(
            icon: MdiIcons.alignHorizontalLeft,
            onTap: () =>
                setState(() => direction = AlignFixturesRequest_AlignDirection.LEFT_TO_RIGHT)),
        PanelHeaderDivider(),
        PanelToolbarButton.icon(
            icon: MdiIcons.alignVerticalTop,
            onTap: () =>
                setState(() => direction = AlignFixturesRequest_AlignDirection.TOP_TO_BOTTOM)),
        PanelHeaderDivider(),
        SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: NumberField(label: "Groups", bar: false, value: groups, onUpdate: (v) => groups = v.toInt()),
          ),
        ),
        PanelHeaderDivider(),
        SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: NumberField(label: "Row Gap", bar: false, value: rowGap, onUpdate: (v) => rowGap = v.toInt()),
          ),
        ),
        PanelHeaderDivider(),
        SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: NumberField(label: "Column Gap", bar: false, value: columnGap, onUpdate: (v) => columnGap = v.toInt()),
          ),
        ),
        PanelHeaderDivider(),
        PanelToolbarButton(child: Text("Apply"), onTap: () => _align()),
        PanelToolbarSectionDivider(),
        SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: NumberField(label: "Rotation", bar: false, value: rotation, onUpdate: (v) => rotation = v.toInt()),
          ),
        ),
        PanelHeaderDivider(),
        PanelToolbarButton.text("Transform", onTap: () => _transform()),
        PanelToolbarSectionDivider(),
        PanelToolbarButton.icon(icon: Icons.square_outlined, onTap: () => _spread(SpreadFixturesRequest_SpreadGeometry.SQUARE)),
        PanelHeaderDivider(),
        PanelToolbarButton.icon(icon: MdiIcons.triangleOutline, onTap: () => _spread(SpreadFixturesRequest_SpreadGeometry.TRIANGLE)),
        PanelToolbarSectionDivider(),
      ]),
    );
  }

  _align() {
    PlansBloc bloc = context.read();

    bloc.add(
        AlignFixtures(direction: direction, groups: groups, rowGap: rowGap, columnGap: columnGap));
  }

  _transform() {
    PlansBloc bloc = context.read();

    bloc.add(TransformFixtures(rotation: rotation));
  }

  _spread(SpreadFixturesRequest_SpreadGeometry geometry) {
    PlansBloc bloc = context.read();
    bloc.add(SpreadFixtures(geometry: geometry));
  }
}

class PanelToolbarButton extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  final bool selected;
  final double? width;

  const PanelToolbarButton({super.key, required this.child, required this.onTap, this.selected = false, this.width});

  factory PanelToolbarButton.icon({required IconData icon, required Function() onTap, bool selected = false}) {
    return PanelToolbarButton(
      width: GRID_2_SIZE,
      onTap: onTap,
      selected: selected,
      child: Icon(icon),
    );
  }

  factory PanelToolbarButton.text(String text, {required Function() onTap, bool selected = false}) {
    return PanelToolbarButton(
      onTap: onTap,
      selected: selected,
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hoverable(
        onTap: onTap,
        builder: (hovered) => Container(
          height: GRID_2_SIZE,
          width: width,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          color: selected ? Grey500 : (hovered ? Grey700 : Grey800),
          child: child,
        ));
  }
}

class PanelToolbarSectionDivider extends StatelessWidget {
  const PanelToolbarSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PanelHeaderDivider(),
        Container(
          height: GRID_2_SIZE,
          width: 4,
          alignment: Alignment.center,
          color: Grey800,
        ),
        PanelHeaderDivider(),
      ],
    );
  }
}
