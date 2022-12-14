import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:provider/provider.dart';

import '../fields/enum_field.dart';
import '../fields/number_field.dart';
import '../property_group.dart';

class MidiProperties extends StatefulWidget {
  final MidiNodeConfig config;
  final Function(MidiNodeConfig) onUpdate;

  MidiProperties(this.config, {required this.onUpdate});

  @override
  _MidiPropertiesState createState() => _MidiPropertiesState(config);
}

class _MidiPropertiesState extends State<MidiProperties> {
  MidiNodeConfig state;
  List<Connection> midiDevices = [];
  List<MidiDeviceProfile> midiDeviceProfiles = [];

  _MidiPropertiesState(this.state);

  @override
  void didUpdateWidget(MidiProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "MIDI", children: [
      EnumField(
        label: "Device",
        initialValue: widget.config.device,
        items: midiDevices.map((e) => SelectOption(value: e.name, label: e.name)).toList(),
        onUpdate: _updateDevice,
      ),
      EnumField(
          label: "Binding",
          initialValue: this.widget.config.whichBinding(),
          items: [
            SelectOption(
                value: MidiNodeConfig_Binding.noteBinding,
                label: "Note"
            ),
            if (deviceProfile != null) SelectOption(
                value: MidiNodeConfig_Binding.controlBinding,
                label: "Control"
            ),
          ],
          onUpdate: _updateBinding,
      ),
      if (state.hasNoteBinding()) ..._noteBinding(),
      if (state.hasControlBinding()) ..._controlBinding(),
    ]);
  }

  List<Widget> _noteBinding() {
    return [
      NumberField(
        label: "Channel",
        value: this.widget.config.noteBinding.channel,
        onUpdate: _updateChannel,
        min: 1,
        max: 16,
        fractions: false,
      ),
      EnumField(
        label: "Mode",
        initialValue: this.widget.config.noteBinding.type.value,
        items: MidiNodeConfig_NoteBinding_MidiType.values.map((v) => SelectOption(value: v.value, label: v.name)).toList(),
        onUpdate: _updateMode,
      ),
      NumberField(
        label: "Port",
        value: this.widget.config.noteBinding.port,
        onUpdate: _updatePort,
        min: 1,
        fractions: false,
      ),
      NumberField(
        label: "Range From",
        value: this.widget.config.noteBinding.rangeFrom,
        onUpdate: _updateRangeFrom,
        min: 1,
        max: 255,
        fractions: false,
      ),
      NumberField(
        label: "Range To",
        value: this.widget.config.noteBinding.rangeTo,
        onUpdate: _updateRangeTo,
        min: 1,
        max: 255,
        fractions: false,
      ),
    ];
  }

  Connection? get device {
    return this.midiDevices.firstWhereOrNull((device) => device.name == state.device);
  }

  MidiDeviceProfile? get deviceProfile {
    if (device == null) {
      return null;
    }
    return this.midiDeviceProfiles.firstWhereOrNull((deviceProfile) => device!.midi.deviceProfile == deviceProfile.id);
  }

  MidiDeviceProfile_Page? get page {
    if (deviceProfile == null) {
      return null;
    }
    return deviceProfile!.pages.firstWhereOrNull((page) => page.name == state.controlBinding.page);
  }

  List<Widget> _controlBinding() {
    return [
      EnumField<String>(
          label: "Page",
          initialValue: state.controlBinding.page,
          items: deviceProfile?.pages.map((page) => SelectOption(value: page.name, label: page.name)).toList() ?? [],
          onUpdate: _updatePage
      ),
      EnumField<String>(
          label: "Control",
          initialValue: state.controlBinding.control,
          items: [
            ..._groups,
            ...getControls(page?.controls ?? []),
          ],
          onUpdate: _updateControl
      ),
    ];
  }
  
  List<SelectGroup<String>> get _groups {
    return page?.groups.map((group) => SelectGroup(group.name, getControls(group.controls))).toList() ?? [];
  }
  
  List<SelectOption<String>> getControls(List<MidiDeviceProfile_Control> controls) {
    return controls.map((control) => SelectOption(value: control.id, label: control.name)).toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchMidiConnections();
  }

  @override
  void activate() {
    super.activate();
    _fetchMidiConnections();
  }

  @override
  void reassemble() {
    super.reassemble();
    _fetchMidiConnections();
  }

  Future _fetchMidiConnections() async {
    var connectionsApi = context.read<ConnectionsApi>();
    var connections = await connectionsApi.getConnections();
    var midiProfiles = await connectionsApi.getMidiDeviceProfiles();
    this.setState(() {
      this.midiDevices = connections.connections.where((connection) => connection.hasMidi()).toList();
      this.midiDeviceProfiles = midiProfiles.profiles;
    });
  }

  void _updateBinding(MidiNodeConfig_Binding binding) {
    log("_updateBinding $binding", name: "MidiProperties");
    setState(() {
      if (binding == MidiNodeConfig_Binding.noteBinding) {
        state.noteBinding = MidiNodeConfig_NoteBinding();
      }
      if (binding == MidiNodeConfig_Binding.controlBinding) {
        state.controlBinding = MidiNodeConfig_ControlBinding(
          page: deviceProfile?.pages.firstOrNull?.name,
        );
      }
      widget.onUpdate(state);
    });
  }

  void _updateChannel(num channel) {
    log("_updateChannel $channel", name: "MidiProperties");
    int value = channel.toInt();
    setState(() {
      state.noteBinding.channel = value;
      widget.onUpdate(state);
    });
  }

  void _updateMode(int modeValue) {
    log("_updateMode $modeValue", name: "MidiProperties");
    setState(() {
      state.noteBinding.type = MidiNodeConfig_NoteBinding_MidiType.valueOf(modeValue)!;
      widget.onUpdate(state);
    });
  }

  void _updatePort(num port) {
    log("_updatePort $port", name: "MidiProperties");
    int value = port.toInt();
    setState(() {
      state.noteBinding.port = value;
      widget.onUpdate(state);
    });
  }

  void _updateRangeFrom(num rangeFrom) {
    log("_updateRangeFrom $rangeFrom", name: "MidiProperties");
    int value = rangeFrom.toInt();
    setState(() {
      state.noteBinding.rangeFrom = value;
      widget.onUpdate(state);
    });
  }

  void _updateRangeTo(num rangeTo) {
    log("_updateRangeTo $rangeTo", name: "MidiProperties");
    int value = rangeTo.toInt();
    setState(() {
      state.noteBinding.rangeTo = value;
      widget.onUpdate(state);
    });
  }

  void _updateDevice(String device) {
    log("_updateDevice $device", name: "MidiProperties");
    setState(() {
      state.device = device;
      widget.onUpdate(state);
    });
  }

  void _updatePage(String page) {
    log("_updateControlPage $page", name: "MidiProperties");
    setState(() {
      state.controlBinding.page = page;
      widget.onUpdate(state);
    });
  }

  void _updateControl(String control) {
    log("_updateControl $control", name: "MidiProperties");
    setState(() {
      state.controlBinding.control = control;
      widget.onUpdate(state);
    });
  }
}
