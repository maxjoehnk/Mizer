import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/number_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/views/media/dialogs/media_tags.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

class MediaMetadataPanel extends StatelessWidget {
  final MediaFile file;

  const MediaMetadataPanel({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleTheme = TextStyle(fontWeight: FontWeight.bold);

    return MizerTable(rows: [
      MizerTableRow(cells: [Text("Name".i18n, style: titleTheme), Text(file.name)]),
      if (file.metadata.hasDimensions())
        MizerTableRow(cells: [
          Text("Dimensions".i18n, style: titleTheme),
          Text("${file.metadata.dimensions.width}x${file.metadata.dimensions.height}")
        ]),
      if (file.metadata.hasFramerate())
        MizerTableRow(
            cells: [Text("Framerate".i18n, style: titleTheme), Text("${file.metadata.framerate} FPS")]),
      if (file.metadata.hasArtist())
        MizerTableRow(cells: [Text("Artist".i18n, style: titleTheme), Text(file.metadata.artist)]),
      if (file.metadata.hasAlbum())
        MizerTableRow(cells: [Text("Album".i18n, style: titleTheme), Text(file.metadata.album)]),
      if (file.metadata.hasDuration())
        MizerTableRow(cells: [
          Text("Duration".i18n, style: titleTheme),
          Text(file.metadata.duration.toInt().toTimeString())
        ]),
      if (file.metadata.hasSampleRate())
        MizerTableRow(cells: [
          Text("Sample Rate".i18n, style: titleTheme),
          Text("${file.metadata.sampleRate} Hz")
        ]),
      if (file.metadata.hasAudioChannelCount())
        MizerTableRow(cells: [
          Text("Channels".i18n, style: titleTheme),
          Text(file.metadata.audioChannelCount.toString())
        ]),
      MizerTableRow(
          cells: [Text("File Size".i18n, style: titleTheme), Text(filesize(file.metadata.fileSize))]),
      MizerTableRow(
          cells: [Text("Source Path".i18n, style: titleTheme), Text(file.metadata.sourcePath)]),
      MizerTableRow(cells: [
        Text("Tags".i18n, style: titleTheme),
        Hoverable(
          builder: (hovered) {
            return Container(
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                        direction: Axis.horizontal,
                        runSpacing: 4.0,
                        spacing: 4.0,
                        children:
                            file.metadata.tags.map((e) => Chip(label: Text(e.name))).toList()),
                  ),
                  Icon(Icons.edit),
                ],
              ),
            );
          },
          onTap: () => _manageTags(context, file),
        )
      ])
    ], columnWidths: {
      0: FlexColumnWidth(1),
      1: FlexColumnWidth(3),
    });
  }

  _manageTags(BuildContext context, MediaFile file) {
    MediaBloc mediaBloc = context.read();
    showDialog(
        context: context,
        builder: (context) => MediaFileTagsDialog(bloc: mediaBloc, fileId: file.id));
  }
}
