import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';

class ConnectionsDemoApi implements ConnectionsApi {
  @override
  Future<Connections> getConnections() async {
    return Connections(connections: [
      Connection(name: "Output", dmx: DmxConnection()),
      Connection(
          name: "CDJ-2000nxs2 - 1",
          proDJLink: ProDjLinkConnection(
              model: "CDJ-2000nxs2",
              address: "192.168.10.2",
              playerNumber: 1,
              playback: CdjPlayback(
                  bpm: 175,
                  frame: 1,
                  live: true,
                  playback: CdjPlayback_State.Playing,
                  track: CdjPlayback_Track(artist: "Pendulum", title: "Witchcraft")))),
      Connection(
          name: "CDJ-2000nxs2 - 2",
          proDJLink: ProDjLinkConnection(
              model: "CDJ-2000nxs2",
              address: "192.168.10.3",
              playerNumber: 2,
              playback: CdjPlayback(
                bpm: 174,
                frame: 0,
                live: false,
                playback: CdjPlayback_State.Cued,
              ))),
      Connection(name: "Helios", helios: HeliosConnection(name: "Helios", firmware: "1.0.0")),
      Connection(name: "Akai APC Mini", midi: MidiConnection()),
      Connection(
        name: "OSC",
        osc: OscConnection(
          inputPort: 9000,
          outputAddress: "127.0.0.1",
          outputPort: 9001,
        ),
      )
    ]);
  }

  @override
  Future<Map<int, List<int>>> monitorDmxConnection(String outputId) {
    // TODO: implement monitorDmxConnection
    throw UnimplementedError();
  }

  @override
  Future<void> addArtnet(AddArtnetRequest request) {
    // TODO: implement addArtnet
    throw UnimplementedError();
  }

  @override
  Future<void> addSacn(AddSacnRequest request) {
    // TODO: implement addSacn
    throw UnimplementedError();
  }

  @override
  Future<MidiDeviceProfiles> getMidiDeviceProfiles() {
    // TODO: implement getMidiDeviceProfiles
    throw UnimplementedError();
  }

  @override
  Stream<MonitorMidiResponse> monitorMidiConnection(String connectionId) {
    // TODO: implement monitorMidiConnection
    throw UnimplementedError();
  }
}
