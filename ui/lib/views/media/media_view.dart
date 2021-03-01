import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/protos/media.pbgrpc.dart';
import 'package:mizer/state/media_bloc.dart';

class MediaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<MediaBloc>().add(MediaEvent.Fetch);
    return BlocBuilder<MediaBloc, MediaFiles>(
        builder: (context, data) => Wrap(
              direction: Axis.horizontal,
              children: data.files.map((file) => MediaFileEntry(file)).toList(),
              crossAxisAlignment: WrapCrossAlignment.start,
            ));
  }
}

class MediaFileEntry extends StatelessWidget {
  final MediaFile file;

  MediaFileEntry(this.file);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: this.file.name,
      child: Card(
          child: Container(
        width: 200,
        child: Column(
          children: [
            MediaThumbnail(this.file),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(this.file.name, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      )),
    );
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
        child: Image.network(this.file.thumbnailUrl));
  }
}
