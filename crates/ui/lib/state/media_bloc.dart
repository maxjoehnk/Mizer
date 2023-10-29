import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/protos/media.pb.dart';

abstract class MediaEvent {}

class FetchMedia extends MediaEvent {}

class ImportMedia extends MediaEvent {
  final List<String> files;

  ImportMedia(this.files);
}

class RemoveMedia extends MediaEvent {
  final String mediaId;

  RemoveMedia(this.mediaId);
}

class RemoveFolder extends MediaEvent {
  final String folder;

  RemoveFolder(this.folder);
}

class AddFolder extends MediaEvent {
  final String folder;

  AddFolder(this.folder);
}

class RemoveTag extends MediaEvent {
  final String tagId;

  RemoveTag(this.tagId);
}

class AddTag extends MediaEvent {
  final String tagName;

  AddTag(this.tagName);
}

class RenameTag extends MediaEvent {
  final String tagId;
  final String tagName;

  RenameTag({required this.tagId, required this.tagName});
}

class AddTagToMedia extends MediaEvent {
  final String mediaId;
  final String tagId;

  AddTagToMedia({required this.mediaId, required this.tagId});
}

class RemoveTagFromMedia extends MediaEvent {
  final String mediaId;
  final String tagId;

  RemoveTagFromMedia({required this.mediaId, required this.tagId});
}

class MediaBloc extends Bloc<MediaEvent, MediaFiles> {
  final MediaApi api;

  MediaBloc(this.api) : super(MediaFiles()) {
    on<FetchMedia>((event, emit) async {
      emit(await _fetch());
    });
    on<ImportMedia>((event, emit) async {
      await api.importMedia(event.files);
      emit(await _fetch());
    });
    on<RemoveMedia>((event, emit) async {
      await api.removeMedia(event.mediaId);
      emit(await _fetch());
    });
    on<AddFolder>((event, emit) async {
      await api.addMediaFolder(event.folder);
      emit(await _fetch());
    });
    on<RemoveFolder>((event, emit) async {
      await api.removeMediaFolder(event.folder);
      emit(await _fetch());
    });
    on<AddTag>((event, emit) async {
      await api.createTag(event.tagName);
      emit(await _fetch());
    });
    on<RemoveTag>((event, emit) async {
      await api.removeTag(event.tagId);
      emit(await _fetch());
    });
    on<AddTagToMedia>((event, emit) async {
      await api.addTagToMedia(event.mediaId, event.tagId);
      emit(await _fetch());
    });
    on<RemoveTagFromMedia>((event, emit) async {
      await api.removeTagFromMedia(event.mediaId, event.tagId);
      emit(await _fetch());
    });
    this.add(FetchMedia());
  }

  Future<MediaFiles> _fetch() async {
    var mediaFiles = await api.getMedia();
    mediaFiles.files.sort((lhs, rhs) => lhs.name.compareTo(rhs.name));
    return mediaFiles;
  }
}
