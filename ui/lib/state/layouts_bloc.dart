import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/protos/layouts.pb.dart';

abstract class LayoutsEvent {}

class FetchLayouts implements LayoutsEvent {}
class AddLayout implements LayoutsEvent {
  final String name;

  AddLayout({ this.name });
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
  }
}
