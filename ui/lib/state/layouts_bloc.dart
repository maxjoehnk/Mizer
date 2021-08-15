import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';

abstract class LayoutsEvent {}

class FetchLayouts implements LayoutsEvent {}
class AddLayout implements LayoutsEvent {
  final String name;

  AddLayout({ this.name });
}
class RemoveLayout implements LayoutsEvent {
  final String id;

  RemoveLayout({ this.id });
}
class RenameLayout implements LayoutsEvent {
  final String id;
  final String name;

  RenameLayout({ this.id, this.name });
}
class RenameControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;
  final String name;

  RenameControl({ this.layoutId, this.controlId, this.name });
}

class UpdateControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;
  final ControlDecorations decorations;

  UpdateControl({ this.layoutId, this.controlId, this.decorations });
}

class MoveControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;
  final ControlPosition position;

  MoveControl({ this.layoutId, this.controlId, this.position });
}
class DeleteControl implements LayoutsEvent {
  final String layoutId;
  final String controlId;

  DeleteControl({ this.layoutId, this.controlId });
}

class AddControl implements LayoutsEvent {
  final String layoutId;
  final Node_NodeType nodeType;
  final ControlPosition position;

  AddControl({ this.layoutId, this.nodeType, this.position });
}

class AddExistingControl implements LayoutsEvent {
  final String layoutId;
  final ControlPosition position;
  final Node node;

  AddExistingControl({ this.layoutId, this.node, this.position });
}

class LayoutsBloc extends Bloc<LayoutsEvent, Layouts> {
  final LayoutsApi api;

  LayoutsBloc(this.api) : super(Layouts());

  @override
  Stream<Layouts> mapEventToState(LayoutsEvent event) async* {
    // TODO: don't fetch layouts after each action when getLayouts returns a stream
    if (event is FetchLayouts) {
      yield await api.getLayouts();
    }
    if (event is AddLayout) {
      yield await api.addLayout(event.name);
      yield await api.getLayouts();
    }
    if (event is RemoveLayout) {
      yield await api.removeLayout(event.id);
      yield await api.getLayouts();
    }
    if (event is RenameLayout) {
      await api.renameLayout(event.id, event.name);
      yield await api.getLayouts();
    }
    if (event is RenameControl) {
      await api.renameControl(event.layoutId, event.controlId, event.name);
      yield await api.getLayouts();
    }
    if (event is DeleteControl) {
      await api.deleteControl(event.layoutId, event.controlId);
      yield await api.getLayouts();
    }
    if (event is AddControl) {
      await api.addControl(event.layoutId, event.nodeType, event.position);
      yield await api.getLayouts();
    }
    if (event is AddExistingControl) {
      await api.addControlForNode(event.layoutId, event.node.path, event.position);
      yield await api.getLayouts();
    }
    if (event is UpdateControl) {
      await api.updateControl(event.layoutId, event.controlId, event.decorations);
      yield await api.getLayouts();
    }
  }
}
