import 'package:bloc/bloc.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/protos/media.pbgrpc.dart';

enum MediaEvent { Fetch }

class MediaBloc extends Bloc<MediaEvent, GroupedMediaFiles> {
  final MediaApiClient client;

  MediaBloc(this.client) : super(GroupedMediaFiles());

  @override
  Stream<GroupedMediaFiles> mapEventToState(MediaEvent event) async* {
    switch (event) {
      case MediaEvent.Fetch:
        yield await client.getTagsWithMedia(GetMediaTags());
        break;
    }
  }
}
