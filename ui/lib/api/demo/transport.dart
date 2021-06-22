import 'package:fixnum/fixnum.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/protos/transport.pb.dart';
import 'package:mizer/protos/transport.pbenum.dart';

class TransportDemoApi implements TransportApi {
  @override
  Future<void> setBPM(double bpm) {
    // TODO: implement setBPM
    throw UnimplementedError();
  }

  @override
  Future<void> setState(TransportState state) {
    // TODO: implement setState
    throw UnimplementedError();
  }

  @override
  Stream<Transport> watchTransport() {
    return Stream.periodic(Duration(milliseconds: 16), (frames) {
      int seconds = (frames / 60).floor();
      int minutes = (seconds / 60).floor();
      int hours = (minutes / 60).floor();

      return Transport(
        speed: 90,
        state: TransportState.Playing,
        timecode: Timecode(
          frames: Int64(frames - (seconds * 60)),
          seconds: Int64(seconds - (minutes * 60)),
          minutes: Int64(minutes - (hours * 60)),
          hours: Int64(hours),
        )
      );
    });
  }
}
