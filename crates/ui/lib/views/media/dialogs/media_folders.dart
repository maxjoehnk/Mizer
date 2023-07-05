import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

const double MAX_DIALOG_WIDTH = 512;
const double MAX_DIALOG_HEIGHT = 512;

class MediaFoldersDialog extends StatelessWidget {
  final MediaBloc bloc;

  const MediaFoldersDialog({required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Media Folders",
        content: Container(
          width: MAX_DIALOG_WIDTH,
          height: MAX_DIALOG_HEIGHT,
          child: BlocBuilder<MediaBloc, MediaFiles>(
            bloc: bloc,
            builder: (context, state) {
              return ListView(
                children: state.folders.paths
                    .map((path) => ListTile(
                          title: Text(path),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => bloc.add(RemoveFolder(path)),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ),
        actions: [
          PopupAction("Close", () => Navigator.of(context).pop()),
          PopupAction("Add", () => _addFolder(context)),
        ]);
  }

  _addFolder(BuildContext context) async {
    var folder = await getDirectoryPath();

    if (folder == null) {
      return;
    }

    bloc.add(AddFolder(folder));
  }
}
