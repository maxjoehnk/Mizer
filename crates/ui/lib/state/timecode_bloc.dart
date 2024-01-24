import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:mizer/api/contracts/timecode.dart';
import 'package:mizer/protos/timecode.pb.dart';

class TimecodeState {
  List<Timecode> timecodes;
  List<TimecodeControl> controls;

  int? selectedTimecodeId;

  TimecodeState({required this.timecodes, required this.controls, this.selectedTimecodeId});

  factory TimecodeState.empty() {
    return TimecodeState(timecodes: [], controls: []);
  }

  Timecode? get selectedTimecode {
    return timecodes.firstWhereOrNull((t) => t.id == selectedTimecodeId);
  }
}

class FetchTimecodes {}

class SelectTimecode {
  final int timecodeId;

  SelectTimecode({required this.timecodeId});
}

class TimecodeUpdated {
  final AllTimecodes timecodes;

  TimecodeUpdated(this.timecodes);
}

class TimecodeBloc extends Bloc<dynamic, TimecodeState> {
  final TimecodeApi api;

  TimecodeBloc(this.api) : super(TimecodeState.empty()) {
    on<AddTimecodeRequest>((event, emit) async {
      await api.addTimecode(event);
    });
    on<RenameTimecodeRequest>((event, emit) async {
      await api.renameTimecode(event);
    });
    on<DeleteTimecodeRequest>((event, emit) async {
      await api.deleteTimecode(event);
    });
    on<AddTimecodeControlRequest>((event, emit) async {
      await api.addTimecodeControl(event);
      emit(await _fetch());
    });
    on<RenameTimecodeControlRequest>((event, emit) async {
      await api.renameTimecodeControl(event);
      emit(await _fetch());
    });
    on<DeleteTimecodeControlRequest>((event, emit) async {
      await api.deleteTimecodeControl(event);
      emit(await _fetch());
    });
    on<FetchTimecodes>((event, emit) async {
      emit(await _fetch());
    });
    on<SelectTimecode>((event, emit) async {
      emit(TimecodeState(
        timecodes: state.timecodes,
        controls: state.controls,
        selectedTimecodeId: event.timecodeId,
      ));
    });
    on<TimecodeUpdated>((event, emit) async {
      emit(TimecodeState(
        timecodes: event.timecodes.timecodes,
        controls: state.controls,
        selectedTimecodeId: state.selectedTimecodeId,
      ));
    });
    this.add(FetchTimecodes());
    this.api.watchTimecodes().listen((event) => this.add(TimecodeUpdated(event)));
  }

  Future<TimecodeState> _fetch() async {
    var timecodes = await api.getTimecodes();

    return TimecodeState(
      timecodes: timecodes.timecodes,
      controls: timecodes.controls,
      selectedTimecodeId: state.selectedTimecodeId,
    );
  }

  selectTimecode(int id) {
    this.add(SelectTimecode(timecodeId: id));
  }

  addTimecode(String name) {
    this.add(AddTimecodeRequest(name: name));
  }

  renameTimecode(int id, String name) {
    this.add(RenameTimecodeRequest(id: id, name: name));
  }

  deleteTimecode(int id) {
    this.add(DeleteTimecodeRequest(id: id));
  }

  addTimecodeControl(String name) {
    this.add(AddTimecodeControlRequest(name: name));
  }

  renameTimecodeControl(int id, String name) {
    this.add(RenameTimecodeControlRequest(id: id, name: name));
  }

  deleteTimecodeControl(int id) {
    this.add(DeleteTimecodeControlRequest(id: id));
  }
}
