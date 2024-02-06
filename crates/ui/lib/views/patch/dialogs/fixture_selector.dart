import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/list_extensions.dart';
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
  String? _manufacturerName;
  FixtureDefinition? definition;
  FixtureMode? mode;
  String? search;

  @override
  void initState() {
    super.initState();
    if (widget.definition != null) {
      this._manufacturerName = _allDefinitions
          .groupByManufacturer()
          .firstWhereOrNull((group) => group.name == widget.definition!.manufacturer)
          ?.name;
    } else {
      this._manufacturerName = _allDefinitions.groupByManufacturer().firstOrNull?.name;
    }
    this.definition = widget.definition;
    this.mode = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                search = value;
              });
              if (_manufacturer == null) {
                _setManufacturer(_manufacturers.firstOrNull?.name);
              }
            },
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FixtureSelectorColumn(
                  label: "Manufacturer", children: _manufacturers.map(_manufacturerItem).toList()),
              _FixtureSelectorColumn(
                  label: "Fixtures", children: _definitions.map(_definitionItem).toList()),
              _FixtureSelectorColumn(
                  label: "Modes", children: definition?.modes.map(_modeItem).toList() ?? []),
              _SelectedFixtureMode(definition, mode)
            ],
          ),
        ),
      ],
    );
  }

  void _setManufacturer(String? manufacturer) {
    setState(() {
      _manufacturerName = manufacturer;
      definition = _definitions.firstOrNull;
    });
  }

  List<_ManufacturerGroup> get _manufacturers {
    return _allDefinitions.groupByManufacturer().sortedBy((element) => element.name).toList();
  }

  _ManufacturerGroup? get _manufacturer {
    return _manufacturers.firstWhereOrNull((m) => m.name == _manufacturerName);
  }

  List<FixtureDefinition> get _allDefinitions {
    return widget.definitions.definitions.search([
      (d) => d.name,
      (d) => d.manufacturer,
    ], search).toList();
  }

  List<FixtureDefinition> get _definitions {
    return _allDefinitions.where((d) => d.manufacturer == _manufacturerName).toList();
  }

  FixtureColumnEntry _manufacturerItem(_ManufacturerGroup manufacturer) {
    var text = manufacturer.name;
    var selected = manufacturer.name == this._manufacturerName;
    var child = Container(
      color: selected ? Colors.black26 : null,
      child: ListTile(
        title: Text(text),
        subtitle: Text("${manufacturer.definitions.length} fixtures"),
        onTap: () => setState(() {
          _setManufacturer(manufacturer.name);
          mode = null;
        }),
      ),
    );

    return FixtureColumnEntry(child: child, text: text);
  }

  FixtureColumnEntry _definitionItem(FixtureDefinition definition) {
    var selected = definition.id == this.definition?.id;
    var child = Container(
      color: selected ? Colors.black26 : null,
      child: ListTile(
          onTap: () => setState(() {
                this.definition = definition;
                mode = null;
              }),
          title: Text(definition.name),
          subtitle: Text(definition.provider)),
    );

    return FixtureColumnEntry(child: child, text: definition.name);
  }

  FixtureColumnEntry _modeItem(FixtureMode mode) {
    var text = mode.name;
    var selected = this.mode?.name == mode.name;
    var child = Container(
      color: selected ? Colors.black26 : null,
      child: ListTile(
        title: Text(text),
        onTap: () {
          setState(() => this.mode = mode);
          widget.onSelect(this.definition!, mode);
        },
      ),
    );

    return FixtureColumnEntry(child: child, text: text);
  }
}

class FixtureColumnEntry {
  final Widget child;
  final String text;

  FixtureColumnEntry({required this.child, required this.text});
}

class _FixtureSelectorColumn extends StatelessWidget {
  final String label;
  final List<FixtureColumnEntry> children;

  _FixtureSelectorColumn({required this.label, required this.children});

  List<Widget> get _children {
    return children.map((e) => e.child).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return FocusTraversalGroup(
      child: Container(
        width: 256,
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(label, style: textTheme.titleMedium, textAlign: TextAlign.center),
            SizedBox(height: 16),
            Expanded(
              child: ListView(children: _children),
            ),
          ],
        ),
      ),
    );
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

extension _FixtureDefinitionGrouping on List<FixtureDefinition> {
  List<_ManufacturerGroup> groupByManufacturer() {
    var groupedDefinitions = groupBy<FixtureDefinition, String>(this, (d) => d.manufacturer);

    return groupedDefinitions
        .mapToList((manufacturer, definitions) => _ManufacturerGroup(manufacturer, definitions));
  }
}

class _ManufacturerGroup {
  String name;
  List<FixtureDefinition> definitions;

  _ManufacturerGroup(this.name, this.definitions);
}
