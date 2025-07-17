import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/protos/media.pb.dart';

abstract class MediaEvent {}

class FetchMedia extends MediaEvent {}

class ImportMedia extends MediaEvent {
  final List<String> files;

  ImportMedia(this.files);
}

class RelinkMedia extends MediaEvent {
  final String mediaId;
  final String path;

  RelinkMedia({ required this.mediaId, required this.path });
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

class MediaChanged extends MediaEvent {
  final List<MediaFile> files;
  final List<MediaTag> tags;

  MediaChanged({required this.files, required this.tags});
}

class SelectMedia extends MediaEvent {
  final MediaFile file;

  SelectMedia(this.file);
}

class MediaState {
  final List<MediaFile> files;
  final List<MediaTag> tags;
  final List<String> folders;
  final MediaFile? selectedFile;

  MediaState({required this.files, required this.tags, required this.folders, this.selectedFile});

  factory MediaState.empty() {
    return MediaState(files: [], tags: [], folders: [], selectedFile: null);
  }
}

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final MediaApi api;

  MediaBloc(this.api) : super(MediaState.empty()) {
    on<FetchMedia>((event, emit) async {
      emit(await _fetch());
    });
    on<ImportMedia>((event, emit) async {
      await api.importMedia(event.files);
    });
    on<RemoveMedia>((event, emit) async {
      await api.removeMedia(event.mediaId);
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
    });
    on<RemoveTag>((event, emit) async {
      await api.removeTag(event.tagId);
    });
    on<AddTagToMedia>((event, emit) async {
      await api.addTagToMedia(event.mediaId, event.tagId);
    });
    on<RemoveTagFromMedia>((event, emit) async {
      await api.removeTagFromMedia(event.mediaId, event.tagId);
    });
    on<MediaChanged>((event, emit) async {
      emit(MediaState(
        files: event.files,
        tags: event.tags,
        folders: state.folders,
        selectedFile: state.selectedFile,
      ));
    });
    on<RelinkMedia>((event, emit) async {
      await api.relinkMedia(event.mediaId, event.path);
      this.add(FetchMedia());
    });
    this.api.watchMedia().listen((value) {
      this.add(MediaChanged(files: value.files, tags: value.tags));
    });
    this.add(FetchMedia());
  }

  Future<MediaState> _fetch() async {
    var mediaFiles = await api.getMedia();

    return MediaState(
      files: mediaFiles.files,
      tags: mediaFiles.tags,
      folders: mediaFiles.folders.paths,
      selectedFile: state.selectedFile,
    );
  }
}
