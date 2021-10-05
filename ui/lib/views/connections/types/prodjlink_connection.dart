// @dart=2.11
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mizer/protos/connections.pb.dart';

const double HEADER_BADGE_HEIGHT = 32;

class ProDJLinkConnectionView extends StatelessWidget {
  final ProDjLinkConnection device;

  ProDJLinkConnectionView({this.device});

  @override
  Widget build(BuildContext context) {
    return CdjConnection(device: device);
  }
}

class CdjConnection extends StatelessWidget {
  final ProDjLinkConnection device;

  CdjConnection({this.device});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: PlayerHeader(device),
        ),
        PlayerBody(device.playback),
      ]),
    );
  }
}

class PlayerHeader extends StatelessWidget {
  final ProDjLinkConnection device;

  PlayerHeader(this.device);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      PlayerNumber(device.playerNumber, device.playback.live),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: PlayingState(device.playback.playback),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: FrameIndicator(device.playback.frame),
      ),
      Expanded(child: Container()),
      DeviceInfo(device),
    ]);
  }
}

class PlayerNumber extends StatelessWidget {
  final int number;
  final bool live;

  PlayerNumber(this.number, this.live);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Container(
        width: 64,
        height: HEADER_BADGE_HEIGHT,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: live ? Colors.red : Colors.grey,
        ),
        child: Text(number.toString().padLeft(2, "0"),
            textAlign: TextAlign.center, style: style.headline6));
  }
}

class PlayingState extends StatelessWidget {
  final Map<CdjPlayback_State, Color> colors = {
    CdjPlayback_State.Playing: Colors.green,
    CdjPlayback_State.Cued: Colors.orange,
    CdjPlayback_State.Cueing: Colors.deepOrange,
    CdjPlayback_State.Loading: Colors.grey,
  };
  final Map<CdjPlayback_State, String> labels = {
    CdjPlayback_State.Playing: "Playing",
    CdjPlayback_State.Cued: "Cued",
    CdjPlayback_State.Cueing: "Cueing",
    CdjPlayback_State.Loading: "Loading",
  };

  final CdjPlayback_State playerState;

  PlayingState(this.playerState);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Container(
        width: 128,
        height: HEADER_BADGE_HEIGHT,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: colors[playerState],
        ),
        child: Text(labels[playerState], textAlign: TextAlign.center, style: style.subtitle1));
  }
}

class FrameIndicator extends StatelessWidget {
  final int frame;

  FrameIndicator(this.frame);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey.shade300,
      ),
      height: HEADER_BADGE_HEIGHT,
      alignment: AlignmentDirectional.center,
      child: Row(children: [
        Frame(frame == 0),
        Frame(frame == 1),
        Frame(frame == 2),
        Frame(frame == 3),
      ]),
    );
  }
}

class Frame extends StatelessWidget {
  final bool active;

  Frame(this.active);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 32,
      height: 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: active ? Colors.deepOrange : Colors.grey,
      ),
    );
  }
}

class PlayerBody extends StatelessWidget {
  final CdjPlayback device;

  PlayerBody(this.device);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CdjIcon(),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: BPM(device.bpm),
      ),
      if (device.track.hasTitle())
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TrackInfo(device.track),
        )
    ]);
  }
}

class CdjIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/cdj.svg',
      width: 64,
      color: Colors.grey.shade600,
    );
  }
}

class BPM extends StatelessWidget {
  final double bpm;

  BPM(this.bpm);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return PlayerMetadata(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(bpm.toStringAsFixed(1), style: style.headline4),
        Text("BPM",
            style: style.bodyText1.copyWith(color: style.bodyText1.color.withAlpha(164)),
            textAlign: TextAlign.start),
      ]),
    );
  }
}

class TrackInfo extends StatelessWidget {
  final CdjPlayback_Track track;

  TrackInfo(this.track);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return PlayerMetadata(
        child: Row(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(track.title, style: style.headline4),
        Text(track.artist, style: style.bodyText2),
      ]),
    ]));
  }
}

class PlayerMetadata extends StatelessWidget {
  final Widget child;

  PlayerMetadata({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 88,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: child);
  }
}

class DeviceInfo extends StatelessWidget {
  final ProDjLinkConnection device;

  DeviceInfo(this.device);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Column(children: [
      Text(device.model, style: style.bodyText1),
      Text(device.address, style: style.caption),
    ], crossAxisAlignment: CrossAxisAlignment.end);
  }
}
