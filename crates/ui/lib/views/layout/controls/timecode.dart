import 'package:flutter/material.dart';
import 'package:mizer/api/plugin/ffi/bindings.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/api/plugin/ffi/transport.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/transport/time_control.dart';

class TimecodeControl extends StatelessWidget {
  final LayoutsRefPointer pointer;
  final LayoutControl control;
  final Color? color;

  const TimecodeControl({required this.pointer, required this.control, required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reader = _LayoutTimecodeReader(pointer, path: control.node.path);

    return PanelGridTile(
      interactive: false,
      color: color,
      child: Center(child: FFITimeControl(pointer: reader, autoSize: true)),
    );
  }
}

class _LayoutTimecodeReader implements TimecodeReader {
  final LayoutsRefPointer _pointer;
  final String path;

  _LayoutTimecodeReader(this._pointer, { required this.path });

  @override
  void dispose() {
  }

  @override
  Timecode readTimecode() {
    return this._pointer.readClockValue(path);
  }
}
