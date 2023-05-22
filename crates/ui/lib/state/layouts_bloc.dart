import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';

abstract class LayoutsEvent {}

class FetchLayouts implements LayoutsEvent {}

class AddLayout implements LayoutsEvent {
  final String name;

  AddLayout({required this.name});
}

class RemoveLayout implements LayoutsEvent {
  final String id;

  RemoveLayout({required this.id});
}

class RenameLayout implements LayoutsEvent {
  final String id;
  final String name;

  RenameLayout({required this.id, required this.name});
}

class RenameControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;
  final String name;

  RenameControl({required this.layoutId, required this.controlId, required this.name});
}

class UpdateControlDecoration implements LayoutsEvent {
  final String layoutId;
  final String controlId;
  final ControlDecorations decorations;

  UpdateControlDecoration(
      {required this.layoutId, required this.controlId, required this.decorations});
}

class UpdateControlBehavior implements LayoutsEvent {
  final String layoutId;
  final String controlId;
  final ControlBehavior behavior;

  UpdateControlBehavior({required this.layoutId, required this.controlId, required this.behavior});
}

class MoveControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;
  final ControlPosition position;

  MoveControl({required this.layoutId, required this.controlId, required this.position});
}

class ResizeControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;
  final ControlSize size;

  ResizeControl({required this.layoutId, required this.controlId, required this.size});
}

class DeleteControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;

  DeleteControl({required this.layoutId, required this.controlId});
}

class AddControl implements LayoutsEvent {
  final String layoutId;
  final Node_NodeType nodeType;
  final ControlPosition position;

  AddControl({required this.layoutId, required this.nodeType, required this.position});
}

class AddExistingControl implements LayoutsEvent {
  final String layoutId;
  final ControlPosition position;
  final Node? node;
  final int? groupId;
  final int? sequenceId;
  final PresetId? presetId;

  AddExistingControl(
      {required this.layoutId,
      this.node,
      this.groupId,
      this.presetId,
      this.sequenceId,
      required this.position});

  factory AddExistingControl.node(
      {required String layoutId, required Node node, required ControlPosition position}) {
    return AddExistingControl(layoutId: layoutId, node: node, position: position);
  }

  factory AddExistingControl.sequence(
      {required String layoutId, required int sequenceId, required ControlPosition position}) {
    return AddExistingControl(layoutId: layoutId, sequenceId: sequenceId, position: position);
  }

  factory AddExistingControl.group(
      {required String layoutId, required int groupId, required ControlPosition position}) {
    return AddExistingControl(layoutId: layoutId, groupId: groupId, position: position);
  }

  factory AddExistingControl.preset(
      {required String layoutId, required PresetId presetId, required ControlPosition position}) {
    return AddExistingControl(layoutId: layoutId, presetId: presetId, position: position);
  }
}

class SelectLayoutTab implements LayoutsEvent {
  final int tabIndex;

  SelectLayoutTab({required this.tabIndex});
}

class LayoutState {
  final List<Layout> layouts;
  final int tabIndex;

  LayoutState({required this.layouts, required this.tabIndex});

  factory LayoutState.empty() {
    return LayoutState(layouts: [], tabIndex: 0);
  }

  LayoutState copyWith({List<Layout>? layouts, int? tabIndex}) {
    return LayoutState(
      layouts: layouts ?? this.layouts,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }
}

class LayoutsBloc extends Bloc<LayoutsEvent, LayoutState> {
  final LayoutsApi api;

  LayoutsBloc(this.api) : super(LayoutState.empty()) {
    // TODO: don't fetch layouts after each action when getLayouts returns a stream
    on<FetchLayouts>((event, emit) async {
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<AddLayout>((event, emit) async {
      await api.addLayout(event.name);
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<RemoveLayout>((event, emit) async {
      await api.removeLayout(event.id);
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<RenameLayout>((event, emit) async {
      await api.renameLayout(event.id, event.name);
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<RenameControl>((event, emit) async {
      await api.renameControl(event.layoutId, event.controlId, event.name);
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<DeleteControl>((event, emit) async {
      await api.deleteControl(event.layoutId, event.controlId);
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<AddControl>((event, emit) async {
      await api.addControl(event.layoutId, event.nodeType, event.position);
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<AddExistingControl>((event, emit) async {
      if (event.node != null) {
        await api.addControlForNode(event.layoutId, event.node!.path, event.position);
      }
      if (event.sequenceId != null) {
        await api.addControlForSequence(event.layoutId, event.sequenceId!, event.position);
      }
      if (event.groupId != null) {
        await api.addControlForGroup(event.layoutId, event.groupId!, event.position);
      }
      if (event.presetId != null) {
        await api.addControlForPreset(event.layoutId, event.presetId!, event.position);
      }
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<UpdateControlDecoration>((event, emit) async {
      await api.updateControlDecoration(event.layoutId, event.controlId, event.decorations);
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<UpdateControlBehavior>((event, emit) async {
      await api.updateControlBehavior(event.layoutId, event.controlId, event.behavior);
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<MoveControl>((event, emit) async {
      await api.moveControl(event.layoutId, event.controlId, event.position);
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<ResizeControl>((event, emit) async {
      await api.resizeControl(event.layoutId, event.controlId, event.size);
      var layouts = await api.getLayouts();
      emit(state.copyWith(layouts: layouts.layouts));
    });
    on<SelectLayoutTab>((event, emit) async {
      emit(state.copyWith(tabIndex: event.tabIndex));
    });
  }
}
