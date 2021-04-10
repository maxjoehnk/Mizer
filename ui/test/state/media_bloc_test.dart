import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  group('MediaBloc', () {
    MockClient client;

    MediaBloc mediaBloc;

    setUp(() {
      client = MockClient();

      mediaBloc = MediaBloc(client);
    });

    test('Initial state should be empty', () {
      expect(mediaBloc.state.files.isEmpty, isTrue);
    });

    // var fetchedMedia = GroupedMediaFiles(tags: [MediaTagWithFiles(files: [], tag: MediaTag(name: "Test"))]);
    // blocTest(
    //     'fetches media when MediaEvent.Fetch is added',
    //     build: () {
    //       when(client.getTagsWithMedia(GetMediaTags())).thenReturn(Future.value(fetchedMedia));
    //
    //       return mediaBloc;
    //     },
    //     act: (bloc) => bloc.add(MediaEvent.Fetch),
    //     expect: [fetchedMedia]
    // );
  });
}

class MockClient extends Mock implements MediaApi {}

