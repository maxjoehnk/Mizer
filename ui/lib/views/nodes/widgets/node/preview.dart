import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/plugin/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

import 'preview/data.dart';
import 'preview/history.dart';
import 'preview/timecode.dart';

const SUPPORTED_PREVIEW_TYPES = [
  Node_NodePreviewType.HISTORY,
  Node_NodePreviewType.DATA,
  Node_NodePreviewType.TIMECODE,
];

class NodePreview extends StatelessWidget {
  final Node node;

  NodePreview(this.node);

  @override
  Widget build(BuildContext context) {
    if (!SUPPORTED_PREVIEW_TYPES.contains(node.preview)) {
      return Container();
    }

    var nodesApi = context.read<NodesApi>();
    if (!(nodesApi is NodesPluginApi)) {
      return Container();
    }
    NodesPluginApi nodesPluginApi = nodesApi;
    if (node.preview == Node_NodePreviewType.HISTORY) {
      return HistoryRenderer(nodesPluginApi, node.path);
    } else if (node.preview == Node_NodePreviewType.DATA) {
      return DataRenderer(nodesPluginApi, node.path);
    } else {
      return TimecodeRenderer(nodesPluginApi, node.path);
    }
  }
}
