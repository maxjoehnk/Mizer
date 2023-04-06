import 'package:flutter/material.dart';
import 'package:mizer/extensions/number_extensions.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

const double thumbnailWidth = 100;

class MediaList extends StatelessWidget {
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
        rows: files.map((file) => _row(file)).toList(),
        columnWidths: {
          0: FixedColumnWidth(thumbnailWidth),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
          3: FlexColumnWidth(1),
        },
      )),
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
    ], onTap: () => onSelectFile(file), selected: selectedFile == file);
  }
}

class MediaThumbnail extends StatelessWidget {
  final MediaFile file;

  MediaThumbnail(this.file);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Image.network(this.file.thumbnailUrl, fit: BoxFit.cover, width: thumbnailWidth));
  }
}
