import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/extensions/context_state_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:provider/provider.dart';

import 'dialogs/project_load_result_dialog.dart';

const PROJECT_V1_EXTENSION = 'yml';
const PROJECT_V2_EXTENSION = 'mshow';

class ProjectFiles {
  static Future<void> openProject(BuildContext context) async {
    final typeGroup = XTypeGroup(label: 'Mizer Showfiles'.i18n, extensions: [PROJECT_V1_EXTENSION, PROJECT_V2_EXTENSION]);
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file == null) {
      return;
    }
    ProjectFiles.openProjectFrom(context, file.path);
  }

  static Future<void> openProjectFrom(BuildContext context, String filePath) async {
    var api = context.read<SessionApi>();
    var result = await api.loadProject(filePath);
    context.refreshAllStates();
    if (result.state != LoadProjectResult_State.OK || result.issues.isNotEmpty) {
      ProjectLoadResultAction? action = await showDialog(context: context, builder: (context) => ProjectLoadResultDialog(result));
      if (action == ProjectLoadResultAction.NewProject) {
        await newProject(context);
      } else if (action == ProjectLoadResultAction.LoadDifferentProject) {
        await openProject(context);
      }
    }
  }

  static Future<void> saveProject(BuildContext context) async {
    await context.read<SessionApi>().saveProject();
  }

  static Future<void> saveProjectAs(BuildContext context) async {
    final typeGroup = XTypeGroup(label: 'Mizer Showfiles'.i18n, extensions: [PROJECT_V2_EXTENSION]);
    final location = await getSaveLocation(acceptedTypeGroups: [typeGroup]);
    if (location == null) {
      return;
    }
    var api = context.read<SessionApi>();
    await api.saveProjectAs(location.path);
  }

  static Future<void> newProject(BuildContext context) async {
    await context.read<SessionApi>().newProject();
    context.refreshAllStates();
  }
}
