import 'package:mizer/protos/nodes.pb.dart';

const List<NodeCategoryData> NODES = [
  NodeCategoryData("Standard", [
    NodeEntryData("Clock", Node_NodeType.Clock),
    NodeEntryData("Fixture", Node_NodeType.Fixture),
    NodeEntryData("Script", Node_NodeType.Script),
    NodeEntryData("Sequence", Node_NodeType.Sequence),
    NodeEntryData("Oscillator", Node_NodeType.Oscillator),
    NodeEntryData("Merge", Node_NodeType.Merge),
    NodeEntryData("Select", Node_NodeType.Select)
  ]),
  NodeCategoryData("DMX", [
    NodeEntryData("DMX Input", null),
    NodeEntryData("DMX Output", Node_NodeType.DmxOutput),
  ]),
  NodeCategoryData("MIDI", [
    NodeEntryData("MIDI Input", Node_NodeType.MidiInput),
    NodeEntryData("MIDI Output", Node_NodeType.MidiOutput),
  ]),
  NodeCategoryData("Inputs", [
    NodeEntryData("Fader", Node_NodeType.Fader),
    NodeEntryData("Button", null),
    NodeEntryData("Color Picker", null),
  ]),
  NodeCategoryData("Video", [
    NodeEntryData("File", Node_NodeType.VideoFile),
    NodeEntryData("Effect", Node_NodeType.VideoEffect),
    NodeEntryData("Output", Node_NodeType.VideoOutput),
    NodeEntryData("Color Balance", Node_NodeType.VideoColorBalance),
    NodeEntryData("Transform", Node_NodeType.VideoTransform),
  ]),
  NodeCategoryData("Laser", [
    NodeEntryData("Ilda", Node_NodeType.IldaFile),
    NodeEntryData("Output", Node_NodeType.Laser)
  ]),
  NodeCategoryData("Pixel", [
    NodeEntryData("Pattern Generator", Node_NodeType.PixelPattern),
    NodeEntryData("DMX Conversion", Node_NodeType.PixelToDmx),
    NodeEntryData("OPC Output", Node_NodeType.OpcOutput),
  ])
];

class NodeCategoryData {
  final String text;
  final List<NodeEntryData> nodes;

  const NodeCategoryData(this.text, this.nodes);
}

class NodeEntryData {
  final String text;
  final Node_NodeType nodeType;

  const NodeEntryData(this.text, this.nodeType);
}
