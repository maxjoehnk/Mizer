import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';

abstract class LayoutsEvent {}

class FetchLayouts implements LayoutsEvent {}
class AddLayout implements LayoutsEvent {
  final String name;

  AddLayout({ required this.name });
}
class RemoveLayout implements LayoutsEvent {
  final String id;

  RemoveLayout({ required this.id });
}
class RenameLayout implements LayoutsEvent {
  final String id;
  final String name;

  RenameLayout({ required this.id, required this.name });
}
class RenameControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;
  final String name;

  RenameControl({ required this.layoutId, required this.controlId, required this.name });
}

class UpdateControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;
  final ControlDecorations decorations;

  UpdateControl({ required this.layoutId, required this.controlId, required this.decorations });
}

class MoveControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;
  final ControlPosition position;

  MoveControl({ required this.layoutId, required this.controlId, required this.position });
}
class DeleteControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;

  DeleteControl({ required this.layoutId, required this.controlId });
}

class AddControl implements LayoutsEvent {
  final String layoutId;
  final Node_NodeType nodeType;
  final ControlPosition position;

  AddControl({ required this.layoutId, required this.nodeType, required this.position });
}

class AddExistingControl implements LayoutsEvent {
  final String layoutId;
  final ControlPosition position;
  final Node node;

  AddExistingControl({ required this.layoutId, required this.node, required this.position });
}

class SelectLayoutTab implements LayoutsEvent {
  final int tabIndex;

  SelectLayoutTab({ required this.tabIndex });
}

class LayoutState {
  final List<Layout> layouts;
  final int tabIndex;

  LayoutState({ required this.layouts, required this.tabIndex });

  factory LayoutState.empty() {
    return LayoutState(layouts: [], tabIndex: 0);
  }

  LayoutState copyWith({ List<Layout>? layouts, int? tabIndex }) {
    return LayoutState(
      layouts: layouts ?? this.layouts,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }
}

class LayoutsBloc extends Bloc<LayoutsEvent, LayoutState> {
  final LayoutsApi api;

  LayoutsBloc(this.api) : super(LayoutState.empty());

  @override
  Stream<LayoutState> mapEventToState(LayoutsEvent event) async* {
    // TODO: don't fetch layouts after each action when getLayouts returns a stream
    if (event is FetchLayouts) {
      var layouts = await api.getLayouts();
      yield state.copyWith(layouts: layouts.layouts);
    }
    if (event is AddLayout) {
      await api.addLayout(event.name);
      var layouts = await api.getLayouts();
      yield state.copyWith(layouts: layouts.layouts);
    }
    if (event is RemoveLayout) {
      await api.removeLayout(event.id);
      var layouts = await api.getLayouts();
      yield state.copyWith(layouts: layouts.layouts);
    }
    if (event is RenameLayout) {
      await api.renameLayout(event.id, event.name);
      var layouts = await api.getLayouts();
      yield state.copyWith(layouts: layouts.layouts);
    }
    if (event is RenameControl) {
      await api.renameControl(event.layoutId, event.controlId, event.name);
      var layouts = await api.getLayouts();
      yield state.copyWith(layouts: layouts.layouts);
    }
    if (event is DeleteControl) {
      await api.deleteControl(event.layoutId, event.controlId);
      var layouts = await api.getLayouts();
      yield state.copyWith(layouts: layouts.layouts);
    }
    if (event is AddControl) {
      await api.addControl(event.layoutId, event.nodeType, event.position);
      var layouts = await api.getLayouts();
      yield state.copyWith(layouts: layouts.layouts);
    }
    if (event is AddExistingControl) {
      await api.addControlForNode(event.layoutId, event.node.path, event.position);
      var layouts = await api.getLayouts();
      yield state.copyWith(layouts: layouts.layouts);
    }
    if (event is UpdateControl) {
      await api.updateControl(event.layoutId, event.controlId, event.decorations);
      var layouts = await api.getLayouts();
      yield state.copyWith(layouts: layouts.layouts);
    }
    if (event is SelectLayoutTab) {
      yield state.copyWith(tabIndex: event.tabIndex);
    }
  }
}
