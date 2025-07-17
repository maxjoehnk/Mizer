import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/views/media/media_metadata.dart';

import '../../widgets/panel.dart';

class MediaMetadataPanel extends StatelessWidget {
  const MediaMetadataPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaBloc, MediaState>(
      buildWhen: (previous, current) => previous.selectedFile != current.selectedFile,
      builder: (context, state) => Panel(
                  label: "Metadata",
            child: state.selectedFile == null ? Container() : MediaMetadata(
                file: state.selectedFile!)),
    );
  }
}
