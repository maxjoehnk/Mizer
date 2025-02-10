import 'package:flutter/material.dart';
import 'package:mizer/project_files.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

Map<LoadProjectResult_State, String> _msg = {
  LoadProjectResult_State.OK: "Project loaded with issues",
  LoadProjectResult_State.MISSING_FILE: "Project file not found",
  LoadProjectResult_State.INVALID_FILE: "Invalid project file",
  LoadProjectResult_State.UNSUPPORTED_FILE_TYPE: "Unsupported file type",
  LoadProjectResult_State.MIGRATION_ISSUE: "Unable to migrate project file to newer version",
  LoadProjectResult_State.UNKNOWN: "Unknown error",
};

enum ProjectLoadResultAction {
  NewProject,
  LoadDifferentProject,
}

class ProjectLoadResultDialog extends StatelessWidget {
  final LoadProjectResult result;

  const ProjectLoadResultDialog(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Project Load Result",
      content: Column(
        children: [
          Text(_msg[result.state]!),
          if (result.issues.isNotEmpty) ...[
            Text("Issues:", style: Theme.of(context).textTheme.titleSmall),
            for (var issue in result.issues) Text(issue),
          ],
        ],
      ),
      actions: [
        if (result.state == LoadProjectResult_State.OK)
          PopupAction("Ok", () => Navigator.of(context).pop()),
        if (result.state != LoadProjectResult_State.OK)
          PopupAction("New Project", () => Navigator.of(context).pop(ProjectLoadResultAction.NewProject)),
        if (result.state != LoadProjectResult_State.OK)
          PopupAction("Load different Project", () => Navigator.of(context).pop(ProjectLoadResultAction.LoadDifferentProject)),
      ],
    );
  }
}
