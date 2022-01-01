import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';

class NodePortList extends StatelessWidget {
  final Node node;
  final bool inputs;
  final bool collapsed;

  NodePortList(this.node, {this.inputs = false, this.collapsed = false});

  @override
  Widget build(BuildContext context) {
    return Column(children: this._getPortWidgets());
  }

  List<Widget> _getPortWidgets() {
    var ports = this._getPorts();
    return ports
        .map((port) => NodePort(node, port, input: this.inputs, collapsed: collapsed))
        .toList();
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
  final bool collapsed;

  NodePort(this.node, this.port, {this.input = true, this.collapsed = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(
      builder: (context, state, _) {
        var model = state.getPortModel(this.node, port, this.input);
        var portKey = model?.key;

        return Transform(
          transform: Matrix4.translationValues(input ? -8 : 8, 0, 0),
          child: DragTarget<ConnectionRequest>(
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
                    )));
              },
              builder: (BuildContext context, List<ConnectionRequest?> candidateData,
                  List<dynamic> rejectedData) {
                List<Widget> children;
                if (collapsed) {
                  children = _collapsed(portKey);
                }else {
                  children = _expanded(portKey);
                }
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2.0),
                  height: DOT_SIZE,
                  child: Row(
                    mainAxisAlignment: input ? MainAxisAlignment.start : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              }),
        );
      },
    );
  }

  List<Widget> _collapsed(GlobalKey? portKey) {
    return [PortDot(port, input: this.input, key: portKey, node: node)];
  }

  List<Widget> _expanded(GlobalKey? portKey) {
    if (!input) {
      return [
        Text(port.name),
        Container(width: 8),
        PortDot(port, input: this.input, key: portKey, node: node),
      ];
    }
    return [
      PortDot(port, input: this.input, key: portKey, node: node),
      Container(width: 8),
      Text(port.name),
    ];
  }
}

class PortDot extends StatelessWidget {
  final Port port;
  final bool input;
  final Node node;
  final Key? key;
  final GlobalKey dragKey = GlobalKey();

  PortDot(this.port, {this.input = false, this.key, required this.node});

  @override
  Widget build(BuildContext context) {
    var color = getColorForProtocol(port.protocol);

    if (input) {
      return Dot(input: input, color: color);
    }

    return Consumer<NodeEditorModel>(
      builder: (context, model, _) {
        return Draggable<ConnectionRequest>(
          hitTestBehavior: HitTestBehavior.translucent,
          data: ConnectionRequest(node: node, port: port, input: input),
          feedback: Container(key: dragKey, width: 8, height: 8),
          onDragStarted: () {
            model.dragNewConnection(NewConnectionModel(node: node, port: port, key: dragKey));
          },
          onDragUpdate: (_) => model.updateNewConnection(),
          onDragEnd: (_) => model.dropNewConnection(),
          child: Dot(input: input, color: color),
        );
      },
    );
  }
}

class Dot extends StatelessWidget {
  final MaterialColor color;
  final bool input;

  const Dot({required this.color, this.input = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dot = DecoratedBox(
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
    );

    if (input) {
      return dot;
    }
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: dot,
    );
  }
}

class ConnectionRequest {
  Port port;
  Node node;
  bool input;

  ConnectionRequest({required this.port, required this.node, required this.input});
}
