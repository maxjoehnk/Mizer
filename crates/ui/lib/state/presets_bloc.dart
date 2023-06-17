import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/panes/programmer/dialogs/select_preset_type_dialog.dart';

class PresetsState {
  final Presets presets;
  final List<Group> groups;

  PresetsState({Presets? presets, List<Group>? groups})
      : this.presets = presets ?? Presets(),
        this.groups = groups ?? [];

  List<Preset> getByPresetType(PresetType type) {
    switch (type) {
      case PresetType.Intensity:
        return presets.intensities;
      case PresetType.Shutter:
        return presets.shutters;
      case PresetType.Color:
        return presets.colors;
      case PresetType.Position:
        return presets.positions;
      default:
        return [];
    }
  }
}

abstract class PresetsEvent {}

class FetchPresets extends PresetsEvent {}

class AddGroup extends PresetsEvent {
  final Group group;

  AddGroup(this.group);
}

class DeleteGroup extends PresetsEvent {
  final int groupId;

  DeleteGroup(this.groupId);
}

class RenameGroup extends PresetsEvent {
  final int groupId;
  final String name;

  RenameGroup(this.groupId, this.name);
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
    on<DeleteGroup>((event, emit) async {
      await this.api.deleteGroup(event.groupId);
      this.add(FetchPresets());
    });
    on<RenameGroup>((event, emit) async {
      await this.api.renameGroup(event.groupId, event.name);
      this.add(FetchPresets());
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
