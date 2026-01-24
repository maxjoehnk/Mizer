import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/views/media/dialogs/tag_name.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

const double MAX_DIALOG_WIDTH = 512;
const double MAX_DIALOG_HEIGHT = 512;

class ManageTagsDialog extends StatelessWidget {
  final MediaBloc bloc;

  const ManageTagsDialog({required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Media Tags".i18n,
        content: Container(
          width: MAX_DIALOG_WIDTH,
          height: MAX_DIALOG_HEIGHT,
          child: BlocBuilder<MediaBloc, MediaFiles>(
            bloc: bloc,
            builder: (context, state) {
              return ListView(
                children: state.tags
                    .map((tag) => ListTile(
                          onTap: () => _renameTag(context, tag),
                          hoverColor: Colors.white30,
                          title: Text(tag.name),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => bloc.add(RemoveTag(tag.id)),
                          ),
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

  _renameTag(BuildContext context, MediaTag tag) async {
    String? name = await showDialog(
        context: context,
        builder: (context) => TagNameDialog(
              name: tag.name,
            ));

    if (name == tag.name || name == null) {
      return;
    }

    bloc.add(RenameTag(tagId: tag.id, tagName: name));
  }
}
