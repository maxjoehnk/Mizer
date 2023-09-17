import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/extensions/context_state_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/status_bar_bloc.dart';
import 'package:provider/provider.dart';

class ProjectFiles {
  static Future<void> openProject(BuildContext context) async {
    final typeGroup = XTypeGroup(label: 'Projects'.i18n, extensions: ['yml']);
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file == null) {
      return;
    }
    ProjectFiles.openProjectFrom(context, file.path);
  }

  static Future<void> openProjectFrom(BuildContext context, String filePath) async {
    context.addStatus("Loading project...".i18n);
    var api = context.read<SessionApi>();
    await api.loadProject(filePath);
    context.addStatus("Project loaded ($filePath)".i18n);
    context.refreshAllStates();
  }

  static Future<void> saveProject(BuildContext context) async {
    context.addStatus("Saving project...".i18n);
    await context.read<SessionApi>().saveProject();
    context.addStatus("Project saved".i18n);
  }

  static Future<void> saveProjectAs(BuildContext context) async {
    final typeGroup = XTypeGroup(label: 'Projects'.i18n, extensions: ['yml']);
    final location = await getSaveLocation(acceptedTypeGroups: [typeGroup]);
    if (location == null) {
      return;
    }
    context.addStatus("Saving project...".i18n);
    var api = context.read<SessionApi>();
    await api.saveProjectAs(location.path);
    context.addStatus("Project saved (${location.path})".i18n);
  }
}
