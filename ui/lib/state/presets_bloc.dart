import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';

class PresetsState {
  final Presets presets;
  final List<Group> groups;

  PresetsState({Presets? presets, List<Group>? groups})
      : this.presets = presets ?? Presets(),
        this.groups = groups ?? [];
}

abstract class PresetsEvent {}

class FetchPresets extends PresetsEvent {}

class AddGroup extends PresetsEvent {
  final Group group;

  AddGroup(this.group);
}

class PresetsBloc extends Bloc<PresetsEvent, PresetsState> {
  final ProgrammerApi api;

  PresetsBloc(this.api) : super(PresetsState()) {
    on<FetchPresets>((event, emit) async {
      List<dynamic> res = await Future.wait([_getGroups(), _getPresets()]);
      List<Group> groups = res[0];
      Presets presets = res[1];

      emit(PresetsState(presets: presets, groups: groups));
    });
    on<AddGroup>((event, emit) {
      emit(PresetsState(
        presets: state.presets,
        groups: [...state.groups, event.group],
      ));
    });
    this.add(FetchPresets());
  }

  Future<Presets> _getPresets() async {
    var presets = await this.api.getPresets();
    presets.intensities.sort((a, b) => a.id.id - b.id.id);
    presets.colors.sort((a, b) => a.id.id - b.id.id);

    return presets;
  }

  Future<List<Group>> _getGroups() async {
    var groups = await this.api.getGroups();
    groups.groups.sort((a, b) => a.id - b.id);

    return groups.groups;
  }
}
