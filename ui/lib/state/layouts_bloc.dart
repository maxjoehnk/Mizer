import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/protos/layouts.pb.dart';

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

class LayoutsBloc extends Bloc<LayoutsEvent, Layouts> {
  final LayoutsApi api;

  LayoutsBloc(this.api) : super(Layouts());

  @override
  Stream<Layouts> mapEventToState(LayoutsEvent event) async* {
    if (event is FetchLayouts) {
      yield await api.getLayouts();
    }
    if (event is AddLayout) {
      yield await api.addLayout(event.name);
    }
    if (event is RemoveLayout) {
      yield await api.removeLayout(event.id);
    }
    if (event is RenameLayout) {
      yield await api.renameLayout(event.id, event.name);
    }
  }
}
