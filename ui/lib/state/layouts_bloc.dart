import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/protos/layouts.pb.dart';

enum LayoutsEvent { Fetch }

class LayoutsBloc extends Bloc<LayoutsEvent, Layouts> {
  final LayoutsApi api;

  LayoutsBloc(this.api) : super(Layouts());

  @override
  Stream<Layouts> mapEventToState(LayoutsEvent event) async* {
    switch (event) {
      case LayoutsEvent.Fetch:
        yield await api.getLayouts();
        break;
    }
  }
}
