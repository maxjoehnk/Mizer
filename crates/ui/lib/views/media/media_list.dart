import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/extensions/number_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/views/media/dialogs/media_folders.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

const double thumbnailWidth = 100;

class MediaList extends StatefulWidget {
  final List<MediaFile> files;
  final MediaFile? selectedFile;
  final Function(MediaFile) onSelectFile;

  const MediaList(
    this.files, {
    super.key,
    this.selectedFile,
    required this.onSelectFile,
  });

  @override
  State<MediaList> createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  String? searchQuery;

  @override
  Widget build(BuildContext context) {
    return Panel(
      label: "Files",
      child: SingleChildScrollView(
          child: MizerTable(
        columns: [
          Container(),
          Text("Name"),
          Text("Duration"),
          Text("Resolution"),
          Text("FPS"),
        ],
        rows: widget.files.search([(f) => f.name], searchQuery).map((file) => _row(file)).toList(),
        columnWidths: {
          0: FixedColumnWidth(thumbnailWidth),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(1),
        },
      )),
      onSearch: (query) => setState(() => this.searchQuery = query),
      actions: [
        PanelActionModel(label: "Add File(s)", onClick: () => _addFiles(context)),
        PanelActionModel(
          label: "Delete",
          disabled: widget.selectedFile == null,
          onClick: () => context.read<MediaBloc>().add(RemoveMedia(widget.selectedFile!.id)),
        ),
        PanelActionModel(label: "Media Folders", onClick: () => _manageMediaFolders(context)),
      ],
    );
  }

  MizerTableRow _row(MediaFile file) {
    return MizerTableRow(cells: [
      MediaThumbnail(file),
      Text(file.name),
      file.metadata.hasDuration()
          ? Text(file.metadata.duration.toInt().toTimeString())
          : Container(),
      file.metadata.hasDimensions()
          ? Text("${file.metadata.dimensions.width}x${file.metadata.dimensions.height}")
          : Container(),
      file.metadata.hasFramerate() ? Text("${file.metadata.framerate}") : Container(),
    ], onTap: () => widget.onSelectFile(file), selected: widget.selectedFile == file);
  }

  _addFiles(BuildContext context) async {
    final videoGroup =
        XTypeGroup(label: 'Videos'.i18n, extensions: ['mp4', 'mov', 'avi', 'webm', 'wmv', 'mkv']);
    final imageGroup =
        XTypeGroup(label: 'Images'.i18n, extensions: ['png', 'jpg', 'jpeg', 'gif', 'webp', 'bmp']);
    var files = await openFiles(acceptedTypeGroups: [videoGroup, imageGroup]);
    if (files.isEmpty) {
      return;
    }
    context.read<MediaBloc>().add(ImportMedia(files.map((f) => f.path).toList()));
  }

  _manageMediaFolders(BuildContext context) {
    MediaBloc bloc = context.read();
    showDialog(context: context, builder: (context) => MediaFoldersDialog(bloc: bloc));
  }
}

class MediaThumbnail extends StatelessWidget {
  final MediaFile file;

  MediaThumbnail(this.file);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: file.hasThumbnailPath()
            ? Image.file(File(file.thumbnailPath), fit: BoxFit.cover, width: thumbnailWidth)
            : Container());
  }
}
