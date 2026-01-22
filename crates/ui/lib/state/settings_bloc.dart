import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/settings.dart';

abstract class SettingsEvent {}

class LoadSettings implements SettingsEvent {}

class ApplyUpdate implements SettingsEvent {
  final UpdateSetting update;

  ApplyUpdate(this.update);
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
    on<ApplyUpdate>((event, emit) async {
      await settingsApi.updateSetting(event.update);
    });
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
