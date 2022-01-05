import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/controls/select.dart';

class MidiConnectionView extends StatelessWidget {
  final MidiConnection device;
  final List<MidiDeviceProfile> deviceProfiles;

  MidiConnectionView({required this.device, required this.deviceProfiles});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Device Profile:"),
            Padding(padding: const EdgeInsets.all(8)),
            Expanded(
              child: MizerSelect(
                  value: device.deviceProfile,
                  options: deviceProfiles
                      .map((dp) => SelectOption(value: dp.id, label: dp.model))
                      .toList(),
                  onChanged: (e) {}),
            ),
            if (deviceProfile != null) _deviceProfile(),
          ]),
        ),
      ],
    );
  }

  Widget _deviceProfile() {
    if (!deviceProfile!.hasLayout() || deviceProfile!.layout.isEmpty) {
      return Container();
    }
    return SvgPicture.string(deviceProfile!.layout, height: 128);
  }

  MidiDeviceProfile? get deviceProfile {
    return this.deviceProfiles.firstWhereOrNull((deviceProfile) => deviceProfile.id == device.deviceProfile);
  }
}
