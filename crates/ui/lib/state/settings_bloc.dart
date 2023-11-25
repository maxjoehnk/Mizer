import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:protobuf/protobuf.dart';

abstract class SettingsEvent {}

class LoadSettings implements SettingsEvent {}

class SaveSettings implements SettingsEvent {}

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
    on<LoadSettings>((event, emit) async => emit(await settingsApi.loadSettings()));
    on<SaveSettings>((event, emit) async {
      await settingsApi.saveSettings(state);
    });
    on<UpdateSettings>((event, emit) => emit(event.update(state.deepCopy())));
    on<_EmitSettings>((event, emit) => emit(event.settings));
    this.add(LoadSettings());
    this.subscription =
        settingsApi.watchSettings().listen((settings) => this.add(_EmitSettings(settings)));
  }

  @override
  Future<void> close() {
    this.subscription!.cancel();
    return super.close();
  }
}
