import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/timecode.dart';
import 'package:mizer/protos/timecode.pb.dart';

class TimecodeBloc extends Bloc<dynamic, AllTimecodes> {
  final TimecodeApi api;

  TimecodeBloc(this.api) : super(AllTimecodes(timecodes: [], controls: [])) {
    on<AddTimecodeRequest>((event, emit) async {
      await api.addTimecode(event);
      emit(await _fetch());
    });
    on<RenameTimecodeRequest>((event, emit) async {
      await api.renameTimecode(event);
      emit(await _fetch());
    });
    on<DeleteTimecodeRequest>((event, emit) async {
      await api.deleteTimecode(event);
      emit(await _fetch());
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
    this.fetch();
  }

  Future<AllTimecodes> _fetch() {
    return api.getTimecodes();
  }

  fetch() {
    _fetch().then((timecodes) => this.emit(timecodes));
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
