import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/surfaces_bloc.dart';
import 'package:mizer/widgets/controls/button.dart';
import 'package:provider/provider.dart';

class SurfaceMappingSettingsPreview extends StatelessWidget {
  final List<NodeSetting> settings;

  const SurfaceMappingSettingsPreview(this.settings, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MizerButton(child: Text("Open Surface"), onClick: () => _openSurface(context));
  }

  String _getSetting(String label) {
    return settings
        .firstWhere((element) {
          return element.hasSelect() && element.label == label;
        })
        .select
        .value;
  }

  _openSurface(BuildContext context) {
    var surfaceId = _getSetting("Surface");
    context.read<SurfacesCubit>().selectSurface(surfaceId);
  }
}
