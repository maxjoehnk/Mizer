import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/popup/popup_menu.dart';

const Map<Node_NodeType, String> NODE_LABELS = {
  Node_NodeType.CLOCK: "Clock",
  Node_NodeType.SCRIPT: "Script",
  Node_NodeType.SEQUENCE: "Sequence",
  Node_NodeType.OSCILLATOR: "Oscillator",
  Node_NodeType.MERGE: "Merge",
  Node_NodeType.SELECT: "Select",
  Node_NodeType.THRESHOLD: "Threshold",
  Node_NodeType.ENCODER: "Encoder",
  Node_NodeType.ENVELOPE: "Envelope",
  Node_NodeType.DMX_OUTPUT: "DMX Output",
  Node_NodeType.MIDI_INPUT: "MIDI Input",
  Node_NodeType.MIDI_OUTPUT: "MIDI Output",
  Node_NodeType.OSC_INPUT: "OSC Input",
  Node_NodeType.OSC_OUTPUT: "OSC Output",
  Node_NodeType.COLOR_CONSTANT: "Color Constant",
  Node_NodeType.COLOR_BRIGHTNESS: "Color Brightness",
  Node_NodeType.COLOR_RGB: "RGB Mixer",
  Node_NodeType.COLOR_HSV: "HSV Mixer",
  Node_NodeType.FADER: "Fader",
  Node_NodeType.BUTTON: "Button",
  Node_NodeType.LABEL: "Label",
  Node_NodeType.VIDEO_FILE: "File",
  Node_NodeType.VIDEO_EFFECT: "Effect",
  Node_NodeType.VIDEO_OUTPUT: "Output",
  Node_NodeType.VIDEO_COLOR_BALANCE: "Color Balance",
  Node_NodeType.VIDEO_TRANSFORM: "Transform",
  Node_NodeType.ILDA_FILE: "Ilda",
  Node_NodeType.LASER: "Output",
  Node_NodeType.PIXEL_PATTERN: "Pattern Generator",
  Node_NodeType.PIXEL_TO_DMX: "DMX Conversion",
  Node_NodeType.OPC_OUTPUT: "OPC Output",
  Node_NodeType.FIXTURE: "Fixture",
  Node_NodeType.PROGRAMMER: "Programmer",
  Node_NodeType.GROUP: "Group",
  Node_NodeType.PRESET: "Preset",
  Node_NodeType.SEQUENCER: "Sequencer",
  Node_NodeType.GAMEPAD: "Gamepad",
  Node_NodeType.CONTAINER: "Container",
  Node_NodeType.MATH: "Math",
  Node_NodeType.MQTT_INPUT: "MQTT Input",
  Node_NodeType.MQTT_OUTPUT: "MQTT Output",
  Node_NodeType.NUMBER_TO_DATA: "Number to Data",
  Node_NodeType.DATA_TO_NUMBER: "Data to Number",
  Node_NodeType.VALUE: "Value",
  Node_NodeType.EXTRACT: "Extract",
  Node_NodeType.TEMPLATE: "Template",
  Node_NodeType.PLAN_SCREEN: "Plan Screen",
  Node_NodeType.DELAY: "Delay",
  Node_NodeType.RAMP: "Ramp",
  Node_NodeType.NOISE: "Noise",
  Node_NodeType.TRANSPORT: "Transport",
  Node_NodeType.G13INPUT: "G13 Input",
  Node_NodeType.G13OUTPUT: "G13 Output",
  Node_NodeType.CONSTANT_NUMBER: "Constant Number",
  Node_NodeType.CONDITIONAL: "Conditional",
  Node_NodeType.TIMECODE_CONTROL: "Timecode Control",
  Node_NodeType.TIMECODE_OUTPUT: "Timecode Output",
  Node_NodeType.AUDIO_FILE: "Audio File",
  Node_NodeType.AUDIO_OUTPUT: "Audio Output",
  Node_NodeType.AUDIO_VOLUME: "Audio Volume",
  Node_NodeType.AUDIO_INPUT: "Audio Input",
  Node_NodeType.AUDIO_MIX: "Audio Mix",
  Node_NodeType.AUDIO_METER: "Audio Meter",
};

final List<NodeCategory> NODES = [
  NodeCategory("Standard", Colors.green, [
    Node_NodeType.CONTAINER,
    Node_NodeType.CLOCK,
    Node_NodeType.SCRIPT,
    Node_NodeType.SEQUENCE,
    Node_NodeType.OSCILLATOR,
    Node_NodeType.MERGE,
    Node_NodeType.SELECT,
    Node_NodeType.THRESHOLD,
    Node_NodeType.ENCODER,
    Node_NodeType.ENVELOPE,
    Node_NodeType.MATH,
    Node_NodeType.DELAY,
    Node_NodeType.RAMP,
    Node_NodeType.NOISE,
    Node_NodeType.CONSTANT_NUMBER,
    Node_NodeType.CONDITIONAL,
    Node_NodeType.TIMECODE_CONTROL,
    Node_NodeType.TIMECODE_OUTPUT,
  ]),
  NodeCategory("Connections", Colors.orange, [
    Node_NodeType.DMX_OUTPUT,
    Node_NodeType.MIDI_INPUT,
    Node_NodeType.MIDI_OUTPUT,
    Node_NodeType.OSC_INPUT,
    Node_NodeType.OSC_OUTPUT,
    Node_NodeType.GAMEPAD,
    Node_NodeType.MQTT_INPUT,
    Node_NodeType.MQTT_OUTPUT,
    Node_NodeType.G13INPUT,
    Node_NodeType.G13OUTPUT,
  ]),
  NodeCategory("Conversions", Colors.grey.shade700, [
    Node_NodeType.NUMBER_TO_DATA,
    Node_NodeType.DATA_TO_NUMBER,
  ]),
  NodeCategory("Controls", Colors.blue, [
    Node_NodeType.FADER,
    Node_NodeType.BUTTON,
    Node_NodeType.LABEL,
    // Node_NodeType.ColorPicker,
  ]),
  NodeCategory("Data", Colors.green, [
    Node_NodeType.VALUE,
    Node_NodeType.EXTRACT,
    Node_NodeType.TEMPLATE,
  ]),
  NodeCategory("Color", Colors.green, [
    Node_NodeType.COLOR_CONSTANT,
    Node_NodeType.COLOR_BRIGHTNESS,
    Node_NodeType.COLOR_RGB,
    Node_NodeType.COLOR_HSV,
  ]),
  NodeCategory("Audio", Colors.green, [
    Node_NodeType.AUDIO_FILE,
    Node_NodeType.AUDIO_INPUT,
    Node_NodeType.AUDIO_OUTPUT,
    Node_NodeType.AUDIO_VOLUME,
    Node_NodeType.AUDIO_MIX,
    Node_NodeType.AUDIO_METER,
  ]),
  NodeCategory("Video", Colors.red, [
    Node_NodeType.VIDEO_FILE,
    Node_NodeType.VIDEO_EFFECT,
    Node_NodeType.VIDEO_OUTPUT,
    Node_NodeType.VIDEO_COLOR_BALANCE,
    Node_NodeType.VIDEO_TRANSFORM,
  ]),
  NodeCategory("Laser", Colors.purple, [
    Node_NodeType.ILDA_FILE,
    Node_NodeType.LASER,
  ]),
  NodeCategory("Pixel", Colors.red, [
    Node_NodeType.PIXEL_PATTERN,
    Node_NodeType.PIXEL_TO_DMX,
    Node_NodeType.OPC_OUTPUT,
  ])
];

class NodeCategory {
  final String label;
  final Color color;
  final List<Node_NodeType> nodes;

  NodeCategory(this.label, this.color, this.nodes);

  PopupCategory<Node_NodeType> get category {
    return PopupCategory(
        label: label, items: nodes.map((e) => PopupItem(e, NODE_LABELS[e]!)).toList());
  }
}
