import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/extensions/number_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/views/media/dialogs/media_folders.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

import 'dialogs/manage_tags.dart';

const double thumbnailWidth = 100;

class MediaList extends StatefulWidget {
  final List<MediaFile> files;
  final List<MediaTag> tags;
  final MediaFile? selectedFile;
  final Function(MediaFile) onSelectFile;

  const MediaList(
    this.files,
    this.tags, {
    super.key,
    this.selectedFile,
    required this.onSelectFile,
  });

  @override
  State<MediaList> createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  String? searchQuery;
  List<MediaTag> _selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return HotkeyConfiguration(
      hotkeySelector: (hotkeys) => hotkeys.media,
      hotkeyMap: {
        "add_media": () => _addFiles(context),
        "delete": () {
          if (widget.selectedFile == null) {
            return;
          }
          context.read<MediaBloc>().add(RemoveMedia(widget.selectedFile!.id));
        },
        "media_folders": () => _manageMediaFolders(context),
        "manage_tags": () => _manageMediaTags(context),
      },
      child: Panel(
        label: "Files",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
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
            Expanded(
              child: SingleChildScrollView(
                  child: MizerTable(
                columns: [
                  Container(),
                  Text("Name"),
                  Text("Duration"),
                  Text("Resolution"),
                  Text("FPS"),
                  Text("Status"),
                ],
                rows:
                    _files.search([(f) => f.name], searchQuery).map((file) => _row(file)).toList(),
                columnWidths: {
                  0: FixedColumnWidth(thumbnailWidth),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                  4: FlexColumnWidth(1),
                  5: FlexColumnWidth(2),
                },
              )),
            ),
          ],
        ),
        onSearch: (query) => setState(() => this.searchQuery = query),
        actions: [
          PanelActionModel(
              label: "Add File(s)", onClick: () => _addFiles(context), hotkeyId: "add_media"),
          PanelActionModel(
            label: "Delete",
            disabled: widget.selectedFile == null,
            onClick: () => context.read<MediaBloc>().add(RemoveMedia(widget.selectedFile!.id)),
            hotkeyId: "delete",
          ),
          PanelActionModel(
            label: "Relink",
            disabled: widget.selectedFile == null,
            onClick: () => _relinkFile(context),
          ),
          PanelActionModel(
              label: "Media Folders",
              onClick: () => _manageMediaFolders(context),
              hotkeyId: "media_folders"),
          PanelActionModel(
              label: "Manage Tags",
              onClick: () => _manageMediaTags(context),
              hotkeyId: "manage_tags")
        ],
      ),
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
      file.fileAvailable ? Text("Ok") : Text("File Missing", style: TextStyle(color: Colors.red)),
    ], onTap: () => widget.onSelectFile(file), selected: widget.selectedFile == file);
  }

  _addFiles(BuildContext context) async {
    final videoGroup =
        XTypeGroup(label: 'Videos'.i18n, extensions: ['mp4', 'mov', 'avi', 'webm', 'wmv', 'mkv']);
    final imageGroup =
        XTypeGroup(label: 'Images'.i18n, extensions: ['png', 'jpg', 'jpeg', 'gif', 'webp', 'bmp']);
    final audioGroup = XTypeGroup(
        label: 'Audio'.i18n,
        extensions: ['wav', 'mp3', 'ogg', 'flac', 'm4a', 'aac', 'wma', 'opus']);
    final vectorGroup = XTypeGroup(label: 'Vector Files'.i18n, extensions: ['svg']);
    final dataGroup = XTypeGroup(label: 'Data'.i18n, extensions: ['csv']);
    final allSupportedGroup = XTypeGroup(
        label: 'All Supported'.i18n,
        extensions: <String>[
          ...videoGroup.extensions ?? [],
          ...imageGroup.extensions ?? [],
          ...audioGroup.extensions ?? [],
          ...vectorGroup.extensions ?? [],
          ...dataGroup.extensions ?? [],
        ].distinct().toList());
    var files = await openFiles(
        acceptedTypeGroups: [allSupportedGroup, videoGroup, imageGroup, audioGroup, vectorGroup, dataGroup]);
    if (files.isEmpty) {
      return;
    }
    context.read<MediaBloc>().add(ImportMedia(files.map((f) => f.path).toList()));
  }

  _relinkFile(BuildContext context) async {
    if (widget.selectedFile == null) {
      return;
    }
    XTypeGroup? typeGroup = null;
    if (widget.selectedFile!.type == MediaType.AUDIO) {
      typeGroup = XTypeGroup(
          label: 'Audio'.i18n,
          extensions: ['wav', 'mp3', 'ogg', 'flac', 'm4a', 'aac', 'wma', 'opus']);
    }
    if (widget.selectedFile!.type == MediaType.IMAGE) {
      typeGroup = XTypeGroup(
          label: 'Images'.i18n, extensions: ['png', 'jpg', 'jpeg', 'gif', 'webp', 'bmp']);
    }
    if (widget.selectedFile!.type == MediaType.VIDEO) {
      typeGroup = XTypeGroup(
          label: 'Videos'.i18n, extensions: ['mp4', 'mov', 'avi', 'webm', 'wmv', 'mkv']);
    }
    if (widget.selectedFile!.type == MediaType.VECTOR) {
      typeGroup = XTypeGroup(label: 'Vector Files'.i18n, extensions: ['svg']);
    }
    if (widget.selectedFile!.type == MediaType.DATA) {
      typeGroup = XTypeGroup(label: 'Data'.i18n, extensions: ['csv']);
    }

    var file = await openFile(acceptedTypeGroups: [typeGroup!]);
    if (file == null) {
      return;
    }

    context.read<MediaBloc>().add(RelinkMedia(mediaId: widget.selectedFile!.id, path: file.path));
  }

  _manageMediaFolders(BuildContext context) {
    MediaBloc bloc = context.read();
    showDialog(context: context, builder: (context) => MediaFoldersDialog(bloc: bloc));
  }

  _manageMediaTags(BuildContext context) {
    MediaBloc bloc = context.read();
    showDialog(context: context, builder: (context) => ManageTagsDialog(bloc: bloc));
  }

  List<MediaFile> get _files {
    return widget.files.where((element) {
      if (_selectedTags.isEmpty) {
        return true;
      }
      return _selectedTags.every((tag) => element.metadata.tags.contains(tag));
    }).toList();
  }
}

class MediaThumbnail extends StatelessWidget {
  final MediaFile file;
  final double width;

  MediaThumbnail(this.file, {this.width = thumbnailWidth});

  @override
  Widget build(BuildContext context) {
    if (!file.fileAvailable) {
      return Container();
    }
    return Container(
        alignment: Alignment.center,
        child: file.hasThumbnailPath()
            ? Image.file(File(file.thumbnailPath), fit: BoxFit.cover, width: width)
            : Container());
  }
}
