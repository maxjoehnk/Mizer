import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/protos/media.pb.dart';

enum MediaEvent { Fetch }

class MediaBloc extends Bloc<MediaEvent, MediaFiles> {
  final MediaApi api;

  MediaBloc(this.api) : super(MediaFiles());

  @override
  Stream<MediaFiles> mapEventToState(MediaEvent event) async* {
    switch (event) {
      case MediaEvent.Fetch:
        yield await api.getMedia();
        break;
    }
  }
}
