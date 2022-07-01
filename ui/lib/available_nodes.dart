import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/popup/popup_menu.dart';

const Map<Node_NodeType, String> NODE_LABELS = {
  Node_NodeType.Clock: "Clock",
  Node_NodeType.Script: "Script",
  Node_NodeType.Sequence: "Sequence",
  Node_NodeType.Oscillator: "Oscillator",
  Node_NodeType.Merge: "Merge",
  Node_NodeType.Select: "Select",
  Node_NodeType.Threshold: "Threshold",
  Node_NodeType.Encoder: "Encoder",
  Node_NodeType.Envelope: "Envelope",
  Node_NodeType.DmxOutput: "DMX Output",
  Node_NodeType.MidiInput: "MIDI Input",
  Node_NodeType.MidiOutput: "MIDI Output",
  Node_NodeType.OscInput: "OSC Input",
  Node_NodeType.OscOutput: "OSC Output",
  Node_NodeType.ColorRgb: "RGB Mixer",
  Node_NodeType.ColorHsv: "HSV Mixer",
  Node_NodeType.Fader: "Fader",
  Node_NodeType.Button: "Button",
  Node_NodeType.VideoFile: "File",
  Node_NodeType.VideoEffect: "Effect",
  Node_NodeType.VideoOutput: "Output",
  Node_NodeType.VideoColorBalance: "Color Balance",
  Node_NodeType.VideoTransform: "Transform",
  Node_NodeType.IldaFile: "Ilda",
  Node_NodeType.Laser: "Output",
  Node_NodeType.PixelPattern: "Pattern Generator",
  Node_NodeType.PixelToDmx: "DMX Conversion",
  Node_NodeType.OpcOutput: "OPC Output",
  Node_NodeType.Fixture: "Fixture",
  Node_NodeType.Programmer: "Programmer",
  Node_NodeType.Group: "Group",
  Node_NodeType.Preset: "Preset",
  Node_NodeType.Sequencer: "Sequencer",
  Node_NodeType.Gamepad: "Gamepad",
  Node_NodeType.Container: "Container",
  Node_NodeType.Math: "Math",
};

final List<PopupCategory<Node_NodeType>> NODES = [
  buildCategory("Standard", [
    Node_NodeType.Container,
    Node_NodeType.Clock,
    Node_NodeType.Script,
    Node_NodeType.Sequence,
    Node_NodeType.Oscillator,
    Node_NodeType.Merge,
    Node_NodeType.Select,
    Node_NodeType.Threshold,
    Node_NodeType.Encoder,
    Node_NodeType.Envelope,
    Node_NodeType.Math,
    Node_NodeType.ColorRgb,
    Node_NodeType.ColorHsv,
  ]),
  buildCategory("Connections", [
    Node_NodeType.DmxOutput,
    Node_NodeType.MidiInput,
    Node_NodeType.MidiOutput,
    Node_NodeType.OscInput,
    Node_NodeType.OscOutput,
    Node_NodeType.Gamepad,
  ]),
  buildCategory("Controls", [
    Node_NodeType.Fader,
    Node_NodeType.Button,
    // Node_NodeType.ColorPicker,
  ]),
  buildCategory("Video", [
    Node_NodeType.VideoFile,
    Node_NodeType.VideoEffect,
    Node_NodeType.VideoOutput,
    Node_NodeType.VideoColorBalance,
    Node_NodeType.VideoTransform,
  ]),
  buildCategory("Laser", [
    Node_NodeType.IldaFile,
    Node_NodeType.Laser,
  ]),
  buildCategory("Pixel", [
    Node_NodeType.PixelPattern,
    Node_NodeType.PixelToDmx,
    Node_NodeType.OpcOutput,
  ])
];

PopupCategory<Node_NodeType> buildCategory(String label, List<Node_NodeType> nodeTypes) {
  return PopupCategory(
      label: label,
      items: nodeTypes
          .map((e) => PopupItem(e, NODE_LABELS[e]!))
          .toList()
  );
}
