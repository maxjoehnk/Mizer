import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/number_extensions.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/widgets/table/table.dart';

class MediaMetadataPanel extends StatelessWidget {
  final MediaFile file;

  const MediaMetadataPanel({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleTheme = TextStyle(fontWeight: FontWeight.bold);

    return MizerTable(rows: [
      MizerTableRow(cells: [Text("Name", style: titleTheme), Text(file.name)]),
      if (file.metadata.hasDimensions())
        MizerTableRow(cells: [
          Text("Dimensions", style: titleTheme),
          Text("${file.metadata.dimensions.width}x${file.metadata.dimensions.height}")
        ]),
      if (file.metadata.hasFramerate())
        MizerTableRow(
            cells: [Text("Framerate", style: titleTheme), Text("${file.metadata.framerate} FPS")]),
      if (file.metadata.hasArtist())
        MizerTableRow(cells: [Text("Artist", style: titleTheme), Text(file.metadata.artist)]),
      if (file.metadata.hasAlbum())
        MizerTableRow(cells: [Text("Album", style: titleTheme), Text(file.metadata.album)]),
      if (file.metadata.hasDuration())
        MizerTableRow(cells: [
          Text("Duration", style: titleTheme),
          Text(file.metadata.duration.toInt().toTimeString())
        ]),
      MizerTableRow(
          cells: [Text("File Size", style: titleTheme), Text(filesize(file.metadata.fileSize))]),
      MizerTableRow(cells: [Text("File Path", style: titleTheme), Text(file.metadata.sourcePath)]),
    ], columnWidths: {
      0: FlexColumnWidth(1),
      1: FlexColumnWidth(3),
    });
  }
}