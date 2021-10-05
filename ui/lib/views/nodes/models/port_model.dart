// @dart=2.11
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';

class PortModel {
  final Port port;
  final GlobalKey key;
  final bool input;
  Offset offset = Offset.infinite;
  Size size = Size.zero;

  PortModel({@required this.key, @required this.port, @required this.input});

  void update(GlobalKey key) {
    if (key.currentContext == null || this.key.currentContext == null) return;
    RenderBox thisBox = this.key.currentContext.findRenderObject();
    RenderBox thatBox = key.currentContext.findRenderObject();
    this.offset = thatBox.globalToLocal(thisBox.localToGlobal(Offset.zero));
    size = thisBox.size;
  }
}
