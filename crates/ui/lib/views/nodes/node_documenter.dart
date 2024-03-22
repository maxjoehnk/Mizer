import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:change_case/change_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/node/base_node.dart';

Future documentNode(BuildContext context, BaseNodeState nodeState) async {
  String path = _getPath(nodeState);
  await _createDirectory(path);
  await _createIndex(nodeState, path);
  await _createDescriptionIfNotExists(nodeState, path);
  await _createNonExistentSettings(nodeState, path);
  await _createNonExistentInputs(nodeState, path);
  await _createNonExistentOutputs(nodeState, path);

  _screenshotNode(context, nodeState);
}

String _getBasePath() {
  var cwd = Directory.current;
  var basePath = "${cwd.path}/docs/modules/nodes";
  return basePath;
}

String _getPath(BaseNodeState nodeState) {
  var basePath = _getBasePath();
  var category = _getCategory(nodeState);
  var name = _getPathName(nodeState);
  var path = "$basePath/pages/$category/$name";

  return path;
}

String _getPathName(BaseNodeState nodeState) => nodeState.node.details.nodeTypeName.toParamCase();

String _getCategory(BaseNodeState nodeState) => nodeState.node.details.category.name.replaceAll("NODE_CATEGORY_", "").toLowerCase();

Future _createDirectory(String path) async {
  await Directory(path).create(recursive: true);
}

void _screenshotNode(BuildContext context, BaseNodeState nodeState) async {
  var basePath = _getBasePath();
  var category = _getCategory(nodeState);
  var name = _getPathName(nodeState);
  var imagesPath = "$basePath/images/$category/$name";
  await _createDirectory(imagesPath);
  final ui.Image image = await nodeState.screenshot();
  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List pngBytes = byteData!.buffer.asUint8List();
  final File file = File("$imagesPath/node.png");
  await file.writeAsBytes(pngBytes);
}

Future _createIndex(BaseNodeState nodeState, String path) async {
  var indexPath = "$path/index.adoc";
  await File(indexPath).writeAsString(_indexTemplate(nodeState));
}

List<String> _listSettingIncludes(BaseNodeState nodeState) {
  return nodeState.node.settings.map((s) => "setting_${s.id.toSnakeCase()}.adoc").toList();
}

List<String> _listInputIncludes(BaseNodeState nodeState) {
  return nodeState.node.inputs.map((p) => "port_input_${p.name.toSnakeCase()}.adoc").toList();
}

List<String> _listOutputIncludes(BaseNodeState nodeState) {
  return nodeState.node.outputs.map((p) => "port_output_${p.name.toSnakeCase()}.adoc").toList();
}

String _indexTemplate(BaseNodeState nodeState) {
  String categoryName = _getCategory(nodeState);
  String nodeName = _getPathName(nodeState);
  List<String> settings = _listSettingIncludes(nodeState);
  List<String> inputs = _listInputIncludes(nodeState);
  List<String> outputs = _listOutputIncludes(nodeState);

  return """= ${nodeState.node.details.nodeTypeName}
include::description.adoc[]

image:$categoryName/$nodeName/node.png[Node Preview]

== Settings

${settings.map((p) => "include::$p[leveloffset=+2]").join("\n")}

== Outputs

${outputs.map((p) => "include::$p[leveloffset=+2]").join("\n")}

== Inputs

${inputs.map((p) => "include::$p[leveloffset=+2]").join("\n")}
""";
}

Future _createDescriptionIfNotExists(BaseNodeState nodeState, String path) async {
  var indexPath = "$path/description.adoc";
  if (await File(indexPath).exists()) {
    return;
  }
  await File(indexPath).create();
}

Future _createNonExistentSettings(BaseNodeState nodeState, String path) async {
  for (var setting in nodeState.node.settings) {
    var filePath = "$path/setting_${setting.id.toSnakeCase()}.adoc";
    if (await File(filePath).exists()) {
      continue;
    }
    await File(filePath).writeAsString(_settingTemplate(setting));
  }
}

String _settingTemplate(NodeSetting setting) {
  return """= ${setting.hasLabel() ? setting.label : setting.id}
""";
}

Future _createNonExistentInputs(BaseNodeState nodeState, String path) async {
  for (var port in nodeState.node.inputs) {
    var filePath = "$path/port_input_${port.name.toSnakeCase()}.adoc";
    if (await File(filePath).exists()) {
      continue;
    }
    await File(filePath).writeAsString(_portTemplate(port));
  }
}

Future _createNonExistentOutputs(BaseNodeState nodeState, String path) async {
  for (var port in nodeState.node.outputs) {
    var filePath = "$path/port_output_${port.name.toSnakeCase()}.adoc";
    if (await File(filePath).exists()) {
      continue;
    }
    await File(filePath).writeAsString(_portTemplate(port));
  }
}

String _portTemplate(Port port) {
  return """= ${port.name}
  
Type: ${port.protocol.name.toLowerCase().toTitleCase()}
""";
}

