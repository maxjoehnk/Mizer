import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';

class PresetsState {
  final Presets presets;
  final List<Group> groups;

  PresetsState({ Presets? presets, List<Group>? groups }) :
    this.presets = presets ?? Presets(),
    this.groups = groups ?? [];
}

abstract class PresetsEvent {}

class FetchPresets extends PresetsEvent {}

class PresetsBloc extends Bloc<PresetsEvent, PresetsState> {
  final ProgrammerApi api;

  PresetsBloc(this.api) : super(PresetsState()) {
    this.add(FetchPresets());
  }

  @override
  Stream<PresetsState> mapEventToState(PresetsEvent event) async* {
    if (event is FetchPresets) {
      List<dynamic> res = await Future.wait([
        _getGroups(),
        _getPresets()
      ]);
      List<Group> groups = res[0];
      Presets presets = res[1];

      yield PresetsState(presets: presets, groups: groups);
    }
  }

  Future<Presets> _getPresets() async {
    var presets = await this.api.getPresets();
    presets.intensities.sort((a, b) => a.id.id - b.id.id);
    presets.color.sort((a, b) => a.id.id - b.id.id);

    return presets;
  }

  Future<List<Group>> _getGroups() async {
    var groups = await this.api.getGroups();

    return groups.groups;
  }
}
