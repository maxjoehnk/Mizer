import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:provider/provider.dart';

import 'package:mizer/views/nodes/consts.dart';

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
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 2.0),
            height: port.multiple ? DOT_SIZE * 2 : DOT_SIZE,
            child: Row(
              mainAxisAlignment: input ? MainAxisAlignment.start : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: collapsed ? _collapsed(portKey) : _expanded(portKey),
            ),
          ),
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
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Grey800,
            ),
            padding: const EdgeInsets.only(bottom: 2, right: 4, left: 4),
            child: Text(port.name)),
        Container(width: 8),
        PortDot(port, input: this.input, key: portKey, node: node),
      ];
    }
    return [
      PortDot(port, input: this.input, key: portKey, node: node),
      Container(width: 8),
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Grey800,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(port.name)),
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
      return _disconnectClickHandler(
          context, Dot(input: input, color: color, multiple: port.multiple));
    }
    return _disconnectClickHandler(context, Consumer<NodeEditorModel>(
      builder: (context, model, _) {
        return Draggable<ConnectionRequest>(
          hitTestBehavior: HitTestBehavior.translucent,
          data: ConnectionRequest(node: node, port: port, input: input),
          feedback: Container(key: dragKey, width: 8, height: 8),
          onDragStarted: () {
            model.dragNewConnection(NewConnectionModel(node: node, port: port, key: dragKey));
          },
          onDragUpdate: (_) => model.updateNewConnection(),
          onDragEnd: (_) {
            if (model.connecting?.target != null) {
              context.read<NodesBloc>().add(LinkNodes(
                  model.connecting!.node,
                  model.connecting!.port,
                  PortOption(
                    node: model.connecting!.target!.node,
                    port: model.connecting!.target!.port.port,
                  )));
            }
            model.dropNewConnection();
          },
          child: Dot(input: input, color: color, multiple: port.multiple),
        );
      },
    ));
  }

  GestureDetector _disconnectClickHandler(BuildContext context, Widget child) {
    return GestureDetector(
      onTap: () {
        if (RawKeyboard.instance.keysPressed.any((key) => [
              LogicalKeyboardKey.control,
              LogicalKeyboardKey.controlLeft,
              LogicalKeyboardKey.controlRight,
            ].contains(key))) {
          context.read<NodesBloc>().add(DisconnectPort(node.path, port.name));
        }
      },
      child: child,
    );
  }
}

class Dot extends StatelessWidget {
  final MaterialColor color;
  final bool input;
  final bool multiple;

  const Dot({required this.color, this.input = false, this.multiple = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dot = Container(
      decoration: ShapeDecoration(
          gradient: RadialGradient(colors: [color.shade400, color.shade700]),
          shadows: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: Offset(2, 2))
          ],
          shape: RoundedRectangleBorder(
              side: BorderSide.none, borderRadius: BorderRadius.circular(DOT_SIZE))),
      width: DOT_SIZE,
      height: multiple ? DOT_SIZE * 2 : DOT_SIZE,
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
