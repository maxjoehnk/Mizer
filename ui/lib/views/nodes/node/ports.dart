import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/protos/nodes.pbgrpc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/graph/state.dart';

import '../consts.dart';

class NodePortList extends StatelessWidget {
  final Node node;
  final bool inputs;

  NodePortList(this.node, {this.inputs});

  @override
  Widget build(BuildContext context) {
    return Column(children: this._getPortWidgets());
  }

  List<Widget> _getPortWidgets() {
    var ports = this._getPorts();
    return ports.map((port) => NodePort(node, port, input: this.inputs)).toList();
  }

  List<Port> _getPorts() {
    if (this.inputs) {
      return this.node.inputs;
    } else {
      return this.node.outputs;
    }
  }
}

class NodePort extends StatelessWidget {
  final Node node;
  final Port port;
  final bool input;

  NodePort(this.node, this.port, {this.input = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphBloc, GraphState>(
      builder: (context, state) {
        var key = state.getKey(this.node, port, this.input);

        return Transform(
          transform: Matrix4.translationValues(input ? -4 : 4, 0, 0),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onSecondaryTapDown: (details) {
                final RenderBox overlay = Overlay.of(context).context.findRenderObject();
                var rect = RelativeRect.fromRect(
                  details.globalPosition & Size(40, 40),
                  Offset.zero & overlay.size,
                );
                NodesBloc nodesBloc = context.read();
                var options = nodesBloc.getAvailablePorts(node, port);
                showMenu(context: context, position: rect, items: options.map((port) => PopupMenuItem(child: Text("${port.port.name}@${port.node.path}"), value: port)).toList())
                .then((value) {
                  if (value == null) {
                    return;
                  }
                  nodesBloc.add(LinkNodes(this.node, port, value));
                });
              },
              child: Row(
                mainAxisAlignment: input ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: input
                    ? [PortDot(port, input: this.input, key: key), Container(width: 8), Text(port.name)]
                    : [
                        Text(port.name),
                        Container(width: 8),
                        PortDot(port, input: this.input, key: key)
                      ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PortDot extends StatelessWidget {
  final Port port;
  final bool input;
  final Key key;

  PortDot(this.port, {this.input, this.key});

  @override
  Widget build(BuildContext context) {
    var color = getColorForProtocol(port.protocol);

    return DecoratedBox(
      decoration: ShapeDecoration(
          gradient: RadialGradient(colors: [color.shade600, color.shade500]),
          shadows: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: Offset(2, 2))
          ],
          shape: CircleBorder(side: BorderSide.none)),
      child: Container(
        width: DOT_SIZE,
        height: DOT_SIZE,
      ),
    );
  }

  MaterialColor getColorForProtocol(ChannelProtocol protocol) {
    switch (protocol) {
      case ChannelProtocol.Single:
        return Colors.yellow;
      case ChannelProtocol.Multi:
        return Colors.green;
      case ChannelProtocol.Gst:
      case ChannelProtocol.Texture:
        return Colors.red;
      default:
        log("no color for protocol ${protocol.name}");
        return Colors.blueGrey;
    }
  }
}
