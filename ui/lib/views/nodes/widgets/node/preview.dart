import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/plugin/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

import 'preview/history.dart';
import 'preview/timecode.dart';

class NodePreview extends StatelessWidget {
  final Node node;

  NodePreview(this.node);

  @override
  Widget build(BuildContext context) {
    if (node.preview != Node_NodePreviewType.History &&
      node.preview != Node_NodePreviewType.Timecode) {
      return Container();
    }

    var nodesApi = context.read<NodesApi>();
    if (!(nodesApi is NodesPluginApi)) {
      return Container();
    }
    NodesPluginApi nodesPluginApi = nodesApi;
    if (node.preview == Node_NodePreviewType.History) {
      return HistoryRenderer(nodesPluginApi, node.path);
    }else {
      return TimecodeRenderer(nodesPluginApi, node.path);
    }
  }
}
