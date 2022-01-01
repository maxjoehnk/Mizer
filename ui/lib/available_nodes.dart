import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/popup_menu/popup_menu.dart';

const List<PopupCategory<Node_NodeType>> NODES = [
  PopupCategory(label: "Standard", items: [
    PopupItem(Node_NodeType.Clock, "Clock"),
    PopupItem(Node_NodeType.Script, "Script"),
    PopupItem(Node_NodeType.Sequence, "Sequence"),
    PopupItem(Node_NodeType.Oscillator, "Oscillator"),
    PopupItem(Node_NodeType.Merge, "Merge"),
    PopupItem(Node_NodeType.Select, "Select"),
    PopupItem(Node_NodeType.Envelope, "Envelope"),
    // PopupItem(null, "DMX Input"),
    PopupItem(Node_NodeType.DmxOutput, "DMX Output"),
    PopupItem(Node_NodeType.MidiInput, "MIDI Input"),
    PopupItem(Node_NodeType.MidiOutput, "MIDI Output"),
    PopupItem(Node_NodeType.ColorRgb, "RGB Mixer"),
    PopupItem(Node_NodeType.ColorHsv, "HSV Mixer"),
  ]),
  PopupCategory(label: "Controls", items: [
    PopupItem(Node_NodeType.Fader, "Fader"),
    PopupItem(Node_NodeType.Button, "Button"),
    // PopupItem(null, "Color Picker"),
  ]),
  PopupCategory(label: "Video", items: [
    PopupItem(Node_NodeType.VideoFile, "File"),
    PopupItem(Node_NodeType.VideoEffect, "Effect"),
    PopupItem(Node_NodeType.VideoOutput, "Output"),
    PopupItem(Node_NodeType.VideoColorBalance, "Color Balance"),
    PopupItem(Node_NodeType.VideoTransform, "Transform"),
  ]),
  PopupCategory(label: "Laser", items: [
    PopupItem(Node_NodeType.IldaFile, "Ilda"),
    PopupItem(Node_NodeType.Laser, "Output")
  ]),
  PopupCategory(label: "Pixel", items: [
    PopupItem(Node_NodeType.PixelPattern, "Pattern Generator"),
    PopupItem(Node_NodeType.PixelToDmx, "DMX Conversion"),
    PopupItem(Node_NodeType.OpcOutput, "OPC Output"),
  ])
];
