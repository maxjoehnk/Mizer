import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/views/media/media_list.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/tile.dart';

import 'field.dart';

const double MAX_DIALOG_WIDTH = 1280;
const double MAX_DIALOG_HEIGHT = 512;
const double TILE_SIZE = 128;

class MediaField extends StatefulWidget {
  final String label;
  final NodeSetting_MediaValue value;
  final Function(NodeSetting_MediaValue) onUpdate;

  MediaField({required this.label, required this.value, required this.onUpdate});

  @override
  _MediaFieldState createState() => _MediaFieldState();
}

class _MediaFieldState extends State<MediaField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: _readView(context),
    );
  }

  Widget _readView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;
    var bloc = context.read<MediaBloc>();
    var file = bloc.state.files.firstWhereOrNull((element) => element.id == widget.value.value);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Field(
          label: this.widget.label,
          child: Hoverable(
              onTap: () => _selectMedia(context),
              builder: (hovered) => Text(
                    file?.name ?? "",
                    style: textStyle,
                    textAlign: TextAlign.center,
                  )),
          suffix: Hoverable(
            onTap: () => _selectMedia(context),
            builder: (hovered) => _mediaSelector(context),
          ),
        ),
        if (file != null)
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            clipBehavior: Clip.antiAlias,
            child: LayoutBuilder(
                builder: (context, constraints) =>
                    MediaThumbnail(file, width: constraints.maxWidth)),
          ),
      ],
    );
  }

  Widget _mediaSelector(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.grey.shade700,
      ),
      clipBehavior: Clip.antiAlias,
      child: Icon(Icons.perm_media_outlined, size: 16),
    );
  }

  void _setValue(String value) {
    log("_setValue $value", name: "MediaField");
    if (widget.value.value != value) {
      widget
          .onUpdate(NodeSetting_MediaValue(value: value, allowedTypes: widget.value.allowedTypes));
    }
  }

  Future<void> _selectMedia(BuildContext context) async {
    var bloc = context.read<MediaBloc>();
    var files = bloc.state.files
        .where((element) => widget.value.allowedTypes.contains(element.type))
        .toList();
    var tags = bloc.state.tags
        .where((tag) => files.any((file) => file.metadata.tags.contains(tag)))
        .toList();
    MediaFile? result = await showDialog(
        context: context, builder: (context) => MediaDialog(mediaFiles: files, tags: tags));
    if (result == null) {
      return;
    }
    _setValue(result.id);
  }
}

class MediaDialog extends StatefulWidget {
  final List<MediaFile> mediaFiles;
  final List<MediaTag> tags;

  const MediaDialog({required this.mediaFiles, super.key, required this.tags});

  @override
  State<MediaDialog> createState() => _MediaDialogState();
}

class _MediaDialogState extends State<MediaDialog> {
  List<MediaTag> _selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Select media",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Wrap(
                direction: Axis.horizontal,
                runSpacing: 4.0,
                spacing: 4.0,
                children: widget.tags
                    .map((e) => FilterChip(
                        label: Text(e.name),
                        selectedColor: Colors.blueGrey.shade500,
                        selected: _selectedTags.contains(e),
                        onSelected: (selected) => setState(() {
                              if (selected) {
                                _selectedTags.add(e);
                              } else {
                                _selectedTags.remove(e);
                              }
                            })))
                    .toList()),
          ),
          Container(
            width: MAX_DIALOG_WIDTH,
            height: MAX_DIALOG_HEIGHT,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (MAX_DIALOG_WIDTH / TILE_SIZE).floor(),
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: _files.length,
              itemBuilder: (context, index) {
                MediaFile file = _files[index];
                return Tile(
                  child: MediaTile(file: file),
                  onClick: () {
                    Navigator.of(context).pop(file);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<MediaFile> get _files {
    return widget.mediaFiles.where((element) {
      if (_selectedTags.isEmpty) {
        return true;
      }
      return _selectedTags.every((tag) => element.metadata.tags.contains(tag));
    }).toList();
  }
}

class MediaTile extends StatelessWidget {
  final MediaFile file;

  const MediaTile({required this.file, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Flexible(
        flex: 2,
        child: Container(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: MediaThumbnail(file)),
      ),
      Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(file.name),
          )),
    ]);
  }
}
