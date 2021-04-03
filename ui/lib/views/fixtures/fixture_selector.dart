import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/extensions/map_extensions.dart';

class FixtureSelector extends StatefulWidget {
  final FixtureDefinitions definitions;
  final Function(FixtureDefinition, FixtureMode) onSelect;

  FixtureSelector(this.definitions, { this.onSelect });

  @override
  _FixtureSelectorState createState() => _FixtureSelectorState();
}

class _FixtureSelectorState extends State<FixtureSelector> {
  _ManufacturerGroup manufacturer;
  FixtureDefinition definition;
  FixtureMode mode;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FixtureSelectorColumn(
            label: "Manufacturer",
            children: widget.definitions
                .groupByManufacturer()
                .sortedBy((element) => element.name)
                .map(manufacturerItem)
                .toList()),
        _FixtureSelectorColumn(
            label: "Fixtures",
            children: manufacturer?.definitions?.map(definitionItem)?.toList() ?? []),
        _FixtureSelectorColumn(
            label: "Modes", children: definition?.modes?.map(modeItem)?.toList() ?? []),
        _SelectedFixtureMode(definition, mode)
      ],
    );
  }

  Widget manufacturerItem(_ManufacturerGroup manufacturer) {
    return ListTile(
      title: Text(manufacturer.name),
      selected: manufacturer.name == this.manufacturer?.name,
      onTap: () => setState(() {
        this.manufacturer = manufacturer;
        mode = null;
        definition = null;
      }),
    );
  }

  Widget definitionItem(FixtureDefinition definition) {
    return ListTile(
        onTap: () => setState(() {
          this.definition = definition;
          mode = null;
        }),
        selected: definition.id == this.definition?.id,
        title: Text(definition.name));
  }

  Widget modeItem(FixtureMode mode) {
    return ListTile(
      title: Text(mode.name),
      onTap: () {
        setState(() => this.mode = mode);
        widget.onSelect(this.definition, mode);
      },
      selected: this.mode?.name == mode.name,
    );
  }
}

class _FixtureSelectorColumn extends StatelessWidget {
  final String label;
  final List<Widget> children;

  _FixtureSelectorColumn({this.label, this.children});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      width: 256,
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: textTheme.subtitle2),
        ),
        ...children
      ]),
    );
  }
}

class _SelectedFixtureMode extends StatelessWidget {
  final FixtureDefinition definition;
  final FixtureMode mode;

  _SelectedFixtureMode(this.definition, this.mode);

  @override
  Widget build(BuildContext context) {
    if (definition == null || mode == null) {
      return Container();
    }
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          definition.name,
          style: textTheme.headline4,
        ),
        Text(
          definition.manufacturer,
          style: textTheme.headline5,
        ),
        Row(children: definition.tags.map((tag) => Chip(label: Text(tag))).toList()),
        Text("Channels", style: textTheme.subtitle1),
        ...mode.channels.map((e) => Text(e.name, style: textTheme.bodyText2)).toList()
      ]),
    );
  }
}

extension _FixtureDefinitionGrouping on FixtureDefinitions {
  List<_ManufacturerGroup> groupByManufacturer() {
    if (this == null) {
      return [];
    }
    var groupedDefinitions = groupBy(this.definitions, (d) => d.manufacturer);

    return groupedDefinitions
        .mapToList((manufacturer, definitions) => _ManufacturerGroup(manufacturer, definitions));
  }
}

class _ManufacturerGroup {
  String name;
  List<FixtureDefinition> definitions;

  _ManufacturerGroup(this.name, this.definitions);
}
