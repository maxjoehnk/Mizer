import 'package:bloc/bloc.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/protos/layouts.pbgrpc.dart';

enum LayoutsEvent { Fetch }

class LayoutsBloc extends Bloc<LayoutsEvent, Layouts> {
  final LayoutsApiClient client;

  LayoutsBloc(this.client) : super(Layouts());

  @override
  Stream<Layouts> mapEventToState(LayoutsEvent event) async* {
    switch (event) {
      case LayoutsEvent.Fetch:
        yield await client.getLayouts(GetLayoutsRequest());
        break;
    }
  }
}
