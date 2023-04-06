import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/protos/media.pb.dart';

enum MediaEvent { Fetch }

class MediaBloc extends Bloc<MediaEvent, MediaFiles> {
  final MediaApi api;

  MediaBloc(this.api) : super(MediaFiles()) {
    on((event, emit) async {
      if (event == MediaEvent.Fetch) {
        var mediaFiles = await api.getMedia();
        mediaFiles.files.sort((lhs, rhs) => lhs.name.compareTo(rhs.name));
        emit(mediaFiles);
      }
    });
  }
}
