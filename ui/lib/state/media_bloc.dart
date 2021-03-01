import 'package:bloc/bloc.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/protos/media.pbgrpc.dart';

enum MediaEvent { Fetch }

class MediaBloc extends Bloc<MediaEvent, MediaFiles> {
  final MediaApiClient client;

  MediaBloc(this.client) : super(MediaFiles());

  @override
  Stream<MediaFiles> mapEventToState(MediaEvent event) async* {
    switch (event) {
      case MediaEvent.Fetch:
        yield await client.getMedia(GetMediaRequest());
        break;
    }
  }
}
