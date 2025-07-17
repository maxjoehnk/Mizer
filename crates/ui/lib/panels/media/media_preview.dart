import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/views/media/media_preview.dart';

import '../../widgets/panel.dart';

class MediaPreviewPanel extends StatelessWidget {
  const MediaPreviewPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaBloc, MediaState>(
      buildWhen: (previous, current) => previous.selectedFile != current.selectedFile,
      builder: (context, state) => Panel(
                  label: "Preview",
            child: state.selectedFile == null ? Container() : MediaPreview(
                file: state.selectedFile!)),
    );
  }
}
