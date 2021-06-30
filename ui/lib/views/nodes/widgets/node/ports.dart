import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';

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
    return Consumer<NodeEditorModel>(
      builder: (context, state, _) {
        var model = state.getPortModel(this.node, port, this.input);
        var key = model.key;

        return Transform(
          transform: Matrix4.translationValues(input ? -4 : 4, 0, 0),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              mainAxisAlignment: input ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: input
                  ? [PortDot(port, input: this.input, key: key, node: node), Container(width: 8), Text(port.name)]
                  : [
                      Text(port.name),
                      Container(width: 8),
                      PortDot(port, input: this.input, key: key, node: node)
                    ],
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
  final Node node;
  final Key key;
  final GlobalKey dragKey = GlobalKey();

  PortDot(this.port, {this.input, this.key, this.node});

  @override
  Widget build(BuildContext context) {
    var color = getColorForProtocol(port.protocol);

    return Consumer<NodeEditorModel>(
      builder: (context, model, _) => DragTarget(
        hitTestBehavior: HitTestBehavior.translucent,
        onWillAccept: (d) => d is ConnectionRequest && d.input != input,
        onAccept: (d) {
          NodesBloc bloc = context.read();
          bloc.add(LinkNodes(
            d.node,
            d.port,
            PortOption(
              node: node,
              port: port,
            )
          ));
        },
        builder: (BuildContext context, List<Object> candidateData, List<dynamic> rejectedData) => Draggable(
          hitTestBehavior: HitTestBehavior.translucent,
          data: ConnectionRequest(node: node, port: port, input: input),
          feedback: Container(key: dragKey, width: 8, height: 8),
          onDragStarted: () {
            model.dragNewConnection(NewConnectionModel(node: node, port: port, key: dragKey));
          },
          onDragUpdate: (_) => model.updateNewConnection(),
          onDragEnd: (_) => model.dropNewConnection(),
          child: DecoratedBox(
            decoration: ShapeDecoration(
                gradient: RadialGradient(colors: [color.shade400, color.shade700]),
                shadows: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: Offset(2, 2))
                ],
                shape: CircleBorder(side: BorderSide.none)),
            child: Container(
              width: DOT_SIZE,
              height: DOT_SIZE,
            ),
          ),
        ),
      ),
    );
  }
}

class ConnectionRequest {
  Port port;
  Node node;
  bool input;

  ConnectionRequest({ this.port, this.node, this.input });
}
