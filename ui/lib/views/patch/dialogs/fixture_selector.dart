import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/map_extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';

class FixtureSelector extends StatefulWidget {
  final FixtureDefinition? definition;
  final FixtureMode? mode;
  final FixtureDefinitions definitions;
  final Function(FixtureDefinition, FixtureMode) onSelect;

  FixtureSelector(this.definitions, {this.definition, this.mode, required this.onSelect});

  @override
  _FixtureSelectorState createState() => _FixtureSelectorState();
}

class _FixtureSelectorState extends State<FixtureSelector> {
  _ManufacturerGroup? manufacturer;
  FixtureDefinition? definition;
  FixtureMode? mode;

  @override
  void initState() {
    super.initState();
    if (widget.definition != null) {
      this.manufacturer = widget.definitions
          .groupByManufacturer()
          .firstWhere((group) => group.name == widget.definition!.manufacturer);
    }
    this.definition = widget.definition;
    this.mode = widget.mode;
  }

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
                .map(_manufacturerItem)
                .toList()),
        _FixtureSelectorColumn(
            label: "Fixtures", children: _definitions.map(_definitionItem).toList()),
        _FixtureSelectorColumn(
            label: "Modes", children: definition?.modes.map(_modeItem).toList() ?? []),
        _SelectedFixtureMode(definition, mode)
      ],
    );
  }

  List<FixtureDefinition> get _definitions {
    if (manufacturer == null) {
      return widget.definitions.definitions;
    }
    return manufacturer!.definitions;
  }

  FixtureColumnEntry _manufacturerItem(_ManufacturerGroup manufacturer) {
    var text = manufacturer.name;
    var child = ListTile(
      title: Text(text),
      selected: manufacturer.name == this.manufacturer?.name,
      onTap: () => setState(() {
        this.manufacturer = manufacturer;
        mode = null;
        definition = null;
      }),
    );

    return FixtureColumnEntry(child: child, text: text);
  }

  FixtureColumnEntry _definitionItem(FixtureDefinition definition) {
    var child = ListTile(
        onTap: () => setState(() {
              this.definition = definition;
              mode = null;
            }),
        selected: definition.id == this.definition?.id,
        title: Text(definition.name),
        subtitle: Text(definition.provider));

    return FixtureColumnEntry(child: child, text: definition.name);
  }

  FixtureColumnEntry _modeItem(FixtureMode mode) {
    var text = mode.name;
    var child = ListTile(
      title: Text(text),
      onTap: () {
        setState(() => this.mode = mode);
        widget.onSelect(this.definition!, mode);
      },
      selected: this.mode?.name == mode.name,
    );

    return FixtureColumnEntry(child: child, text: text);
  }
}

class FixtureColumnEntry {
  final Widget child;
  final String text;

  FixtureColumnEntry({required this.child, required this.text});
}

class _FixtureSelectorColumn extends StatefulWidget {
  final String label;
  final List<FixtureColumnEntry> children;

  _FixtureSelectorColumn({required this.label, required this.children});

  @override
  State<_FixtureSelectorColumn> createState() => _FixtureSelectorColumnState();
}

class _FixtureSelectorColumnState extends State<_FixtureSelectorColumn> {
  String _query = "";

  List<Widget> get _children {
    return widget.children
        .where((e) => e.text.toLowerCase().contains(_query))
        .map((e) => e.child)
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return FocusTraversalGroup(
      child: Container(
        width: 256,
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label, style: textTheme.subtitle2),
            TextField(
              decoration: InputDecoration(labelText: "Search"),
              autofocus: true,
              onChanged: _updateSearch,
            ),
            Expanded(
              child: ListView(children: _children),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSearch(String query) {
    setState(() => _query = query.toLowerCase());
  }
}

class _SelectedFixtureMode extends StatelessWidget {
  final FixtureDefinition? definition;
  final FixtureMode? mode;

  _SelectedFixtureMode(this.definition, this.mode);

  @override
  Widget build(BuildContext context) {
    if (definition == null || mode == null) {
      return Container();
    }
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              definition!.name,
              style: textTheme.headlineMedium,
            ),
            Text(
              definition!.manufacturer,
              style: textTheme.headlineSmall,
            ),
            Row(children: definition!.tags.map((tag) => Chip(label: Text(tag))).toList()),
            Text("Channels", style: textTheme.titleMedium),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: mode!.channels
                        .map((e) => Text(e.name, style: textTheme.bodyMedium))
                        .toList()),
              ),
            )
          ]),
    );
  }
}

extension _FixtureDefinitionGrouping on FixtureDefinitions? {
  List<_ManufacturerGroup> groupByManufacturer() {
    if (this == null) {
      return [];
    }
    var groupedDefinitions =
        groupBy<FixtureDefinition, String>(this!.definitions, (d) => d.manufacturer);

    return groupedDefinitions
        .mapToList((manufacturer, definitions) => _ManufacturerGroup(manufacturer, definitions));
  }
}

class _ManufacturerGroup {
  String name;
  List<FixtureDefinition> definitions;

  _ManufacturerGroup(this.name, this.definitions);
}
