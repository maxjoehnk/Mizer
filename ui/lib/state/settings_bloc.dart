import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/settings.dart';

class SettingsBloc extends Bloc<dynamic, Settings> {
  final SettingsApi settingsApi;

  SettingsBloc(this.settingsApi) : super(Settings()) {
    this.add(null);
  }

  @override
  Stream<Settings> mapEventToState(dynamic event) async* {
    yield await settingsApi.loadSettings();
  }
}
