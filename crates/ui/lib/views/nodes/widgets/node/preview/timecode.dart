import 'package:flutter/material.dart';
import 'package:mizer/api/plugin/nodes.dart';
import 'package:mizer/shell/transport/time_control.dart';

class TimecodeRenderer extends StatefulWidget {
  final NodesPluginApi pluginApi;
  final String path;

  const TimecodeRenderer(this.pluginApi, this.path) : super();

  @override
  State<TimecodeRenderer> createState() =>
      _TimecodeRendererState(this.pluginApi.getHistoryPointer(path));
}

class _TimecodeRendererState extends State<TimecodeRenderer> {
  final Future<NodeHistoryPointer> _pointer;

  _TimecodeRendererState(this._pointer);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _pointer,
        builder: (context, AsyncSnapshot<NodeHistoryPointer> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FFITimeControl(pointer: snapshot.requireData, textStyle: TextStyle(fontSize: 40)),
          );
        });
  }
}
