import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/settings.dart';

abstract class MidiProfilesEvent {}

class LoadMidiProfiles implements MidiProfilesEvent {}

class ReloadMidiProfiles implements MidiProfilesEvent {}

class MidiProfilesState {
  List<MidiDeviceProfile> profiles;

  MidiProfilesState({required this.profiles});

  factory MidiProfilesState.empty() {
    return MidiProfilesState(profiles: []);
  }

  MidiProfilesState copyWith({List<MidiDeviceProfile>? profiles}) {
    return MidiProfilesState(profiles: profiles ?? this.profiles);
  }
}

class MidiProfilesBloc extends Bloc<MidiProfilesEvent, MidiProfilesState> {
  final SettingsApi settingsApi;

  MidiProfilesBloc(this.settingsApi) : super(MidiProfilesState.empty()) {
    on<LoadMidiProfiles>((event, emit) async {
      var profiles = await settingsApi.loadMidiDeviceProfiles();
      emit(state.copyWith(profiles: profiles));
    });
    on<ReloadMidiProfiles>((event, emit) async {
      await settingsApi.reloadMidiDeviceProfiles();
      add(LoadMidiProfiles());
    });
    add(LoadMidiProfiles());
  }
}
