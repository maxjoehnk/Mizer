import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/protos/media.pbgrpc.dart';
import 'package:mizer/state/media_bloc.dart';

class MediaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<MediaBloc>().add(MediaEvent.Fetch);
    return BlocBuilder<MediaBloc, GroupedMediaFiles>(
        builder: (context, data) =>
            ListView(children: data.tags.map((tag) => TagRow(tag)).toList()));
  }
}

class TagRow extends StatelessWidget {
  final MediaTagWithFiles tag;

  TagRow(this.tag);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        TagTitle(tag.tag),
        Row(
          children: this.tag.files.map((file) => MediaFileEntry(file)).toList(),
        ),
      ], crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  // TODO: allow file upload
  void _openFile(BuildContext context) async {
    final List<XFile> files = await FileSelectorPlatform.instance.openFiles();
  }
}

class TagTitle extends StatelessWidget {
  final MediaTag tag;

  const TagTitle(
    this.tag, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(this.tag.name),
    );
  }
}

class MediaFileEntry extends StatelessWidget {
  final MediaFile file;

  MediaFileEntry(this.file);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        MediaThumbnail(this.file),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(this.file.name),
        ),
      ],
    ));
  }
}

class MediaThumbnail extends StatelessWidget {
  final MediaFile file;

  MediaThumbnail(this.file);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment.center,
      color: Colors.black,
      child: Image.network(this.file.thumbnailUrl)
    );
  }
}
