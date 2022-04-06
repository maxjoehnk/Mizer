import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:nativeshell/nativeshell.dart';
import 'package:protobuf/protobuf.dart';

abstract class SettingsEvent {}

class LoadSettings implements SettingsEvent {}

class SaveSettings implements SettingsEvent {
  final Window window;

  SaveSettings(this.window);
}

class UpdateSettings implements SettingsEvent {
  final Settings Function(Settings) update;

  UpdateSettings(this.update);
}

class SettingsBloc extends Bloc<SettingsEvent, Settings> {
  final SettingsApi settingsApi;

  SettingsBloc(this.settingsApi) : super(Settings()) {
    this.add(LoadSettings());
  }

  @override
  Stream<Settings> mapEventToState(SettingsEvent event) async* {
    if (event is LoadSettings) {
      yield await settingsApi.loadSettings();
    }
    if (event is SaveSettings) {
      await settingsApi.saveSettings(state);
      await event.window.close();
    }
    if (event is UpdateSettings) {
      yield event.update(state.deepCopy());
    }
  }
}
