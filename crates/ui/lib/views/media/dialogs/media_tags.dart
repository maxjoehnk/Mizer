import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/views/media/dialogs/tag_name.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

const double MAX_DIALOG_WIDTH = 512;
const double MAX_DIALOG_HEIGHT = 256;

class MediaFileTagsDialog extends StatelessWidget {
  final MediaBloc bloc;
  final String fileId;

  const MediaFileTagsDialog({required this.bloc, super.key, required this.fileId});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Tags".i18n,
        content: Container(
          width: MAX_DIALOG_WIDTH,
          height: MAX_DIALOG_HEIGHT,
          child: BlocBuilder<MediaBloc, MediaFiles>(
            bloc: bloc,
            builder: (context, state) {
              var file = state.files.firstWhere((element) => element.id == fileId);
              return Wrap(
                spacing: 4,
                runSpacing: 4,
                children: state.tags
                    .map((tag) => FilterChip(
                          selectedColor: Colors.blueGrey.shade500,
                          selected: file.metadata.tags.contains(tag),
                          onSelected: (selected) {
                            if (selected) {
                              bloc.add(AddTagToMedia(mediaId: fileId, tagId: tag.id));
                            } else {
                              bloc.add(RemoveTagFromMedia(mediaId: fileId, tagId: tag.id));
                            }
                          },
                          label: Text(tag.name),
                        ))
                    .toList(),
              );
            },
          ),
        ),
        actions: [
          PopupAction("Add Tag".i18n, () => _addTag(context)),
          PopupAction("Close".i18n, () => Navigator.of(context).pop()),
        ]);
  }

  _addTag(BuildContext context) async {
    String? name = await showDialog(context: context, builder: (context) => TagNameDialog());

    if (name == null) {
      return;
    }

    bloc.add(AddTag(name));
  }
}
