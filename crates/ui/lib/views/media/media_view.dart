import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/widgets/panel.dart';

import 'media_list.dart';
import 'media_metadata.dart';
import 'media_preview.dart';

class MediaView extends StatefulWidget {
  @override
  State<MediaView> createState() => _MediaViewState();
}

class _MediaViewState extends State<MediaView> {
  MediaFile? selectedFile;

  @override
  Widget build(BuildContext context) {
    context.read<MediaBloc>().add(FetchMedia());
    return BlocBuilder<MediaBloc, MediaFiles>(
        builder: (context, data) => MediaLayout(
              list: MediaList(data.files, data.tags,
                  selectedFile: selectedFile,
                  onSelectFile: (file) => setState(() => this.selectedFile = file)),
              preview: Panel(
                  label: "Preview",
                  child: selectedFile == null ? Container() : MediaPreview(file: selectedFile!)),
              metadata: Panel(
                  label: "Metadata",
                  child:
                      selectedFile == null ? Container() : MediaMetadataPanel(file: selectedFile!)),
            ));
  }
}

class MediaLayout extends StatelessWidget {
  final Widget list;
  final Widget preview;
  final Widget metadata;

  const MediaLayout({Key? key, required this.list, required this.preview, required this.metadata})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(spacing: PANEL_GAP_SIZE, children: [
      Flexible(child: list, flex: 2),
      Flexible(
          child: Column(
            spacing: PANEL_GAP_SIZE,
            children: [Flexible(child: preview, flex: 1), Flexible(child: metadata, flex: 2)],
          ),
          flex: 1)
    ]);
  }
}
