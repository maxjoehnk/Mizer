import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/views/media/media_list.dart';

class MediaListPanel extends StatelessWidget {
  const MediaListPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaBloc, MediaState>(
        builder: (context, data) => MediaList(data.files, data.tags,
              selectedFile: data.selectedFile,
              onSelectFile: (file) => context.read<MediaBloc>().add(SelectMedia(file))),
        );
  }
}
