import 'dart:async';

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

class _EmitSettings implements SettingsEvent {
  final Settings settings;

  _EmitSettings(this.settings);
}

class SettingsBloc extends Bloc<SettingsEvent, Settings> {
  final SettingsApi settingsApi;
  StreamSubscription? subscription;

  SettingsBloc(this.settingsApi) : super(Settings()) {
    this.add(LoadSettings());
    this.subscription = settingsApi.watchSettings().listen((settings) => this.add(_EmitSettings(settings)));
  }

  @override
  Future<void> close() {
    this.subscription!.cancel();
    return super.close();
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
    if (event is _EmitSettings) {
      yield event.settings;
    }
  }
}
