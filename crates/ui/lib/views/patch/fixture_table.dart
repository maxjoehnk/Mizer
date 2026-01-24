import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/popup/popup_dmx_address_input.dart';
import 'package:mizer/widgets/popup/popup_input.dart';
import 'package:mizer/widgets/popup/popup_select.dart';
import 'package:mizer/widgets/table/table.dart';

class FixtureTable extends StatelessWidget {
  final List<Fixture> fixtures;
  final List<int> selectedIds;
  final Function(int, bool) onSelect;
  final Function(Fixture) onSelectSimilar;
  final Function(int, UpdateFixtureRequest) onUpdateFixture;

  FixtureTable(
      {required this.fixtures,
      required this.selectedIds,
      required this.onSelect,
      required this.onSelectSimilar,
      required this.onUpdateFixture,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MizerTableRow> rows = _getRows(context);

    return MizerTable(columnWidths: {
      0: FixedColumnWidth(64),
    }, columns: [
      Text("Id".i18n),
      Text("Name".i18n),
      Text("Address".i18n),
      Text("Manufacturer".i18n),
      Text("Model".i18n),
      Text("Mode".i18n),
      Text("Invert Pan".i18n),
      Text("Invert Tilt".i18n),
      Text("Reverse Pixel Order".i18n),
    ], rows: rows);
  }

  List<MizerTableRow> _getRows(BuildContext context) {
    List<MizerTableRow> rows = [];
    for (var fixture in fixtures) {
      rows.add(_fixtureRow(context, fixture));
    }
    return rows;
  }

  MizerTableRow _fixtureRow(BuildContext context, Fixture fixture) {
    var selected = selectedIds.contains(fixture.id);
    var row = MizerTableRow(
      cells: [
        Text(fixture.id.toString()),
        nameField(context, fixture,
            (name) => onUpdateFixture(fixture.id, UpdateFixtureRequest(name: name))),
        addressField(context, fixture,
            (address) => onUpdateFixture(fixture.id, UpdateFixtureRequest(address: address))),
        Text(fixture.manufacturer),
        Text(fixture.model),
        Text(fixture.mode),
        invertedAxisField(context, "Invert Pan".i18n, fixture.config.invertPan,
            (invertPan) => onUpdateFixture(fixture.id, UpdateFixtureRequest(invertPan: invertPan))),
        invertedAxisField(
            context,
            "Invert Tilt".i18n,
            fixture.config.invertTilt,
            (invertTilt) =>
                onUpdateFixture(fixture.id, UpdateFixtureRequest(invertTilt: invertTilt))),
        reversePixelField(
            context,
            "Reverse Pixel Order".i18n,
            fixture.config.reversePixelOrder,
            (reversePixelOrder) => onUpdateFixture(
                fixture.id, UpdateFixtureRequest(reversePixelOrder: reversePixelOrder))),
      ],
      onTap: () => onSelect(fixture.id, !selected),
      onDoubleTap: () => onSelectSimilar(fixture),
      selected: selected,
    );
    return row;
  }
}

Widget nameField(BuildContext context, Fixture fixture, Function(String) onUpdate) {
  return PopupTableCell(
      child: Text(fixture.name),
      popup: PopupInput(
        title: "Name".i18n,
        value: fixture.name,
        onChange: onUpdate,
      ));
}

Widget addressField(BuildContext context, Fixture fixture, Function(FixtureAddress) onUpdate) {
  return PopupTableCell(
      child: Text("${fixture.universe}.${fixture.channel.toString().padLeft(3, "0")}"),
      popup: PopupDmxAddressInput(
        title: "Address".i18n,
        value: FixtureAddress(universe: fixture.universe, channel: fixture.channel),
        onChange: onUpdate,
      ));
}

Widget invertedAxisField(
    BuildContext context, String title, bool inverted, Function(bool) onUpdate) {
  return PopupTableCell(
      child: Text(inverted ? "Inverted".i18n : "Normal".i18n,
          style: inverted ? null : TextStyle(color: Colors.white54)),
      popup: PopupSelect(title: title, items: [
        SelectItem(
            title: "Normal".i18n,
            onTap: () => onUpdate(false)),
        SelectItem(
            title: "Inverted".i18n,
            onTap: () => onUpdate(true))
      ]));
}

Widget reversePixelField(
    BuildContext context, String title, bool reversed, Function(bool) onUpdate) {
  return PopupTableCell(
      child: Text(reversed ? "Reversed".i18n : "Normal".i18n,
          style: reversed ? null : TextStyle(color: Colors.white54)),
      popup: PopupSelect(title: title, items: [
        SelectItem(
            title: "Normal".i18n,
            onTap: () => onUpdate(false)),
        SelectItem(
            title: "Reversed".i18n,
            onTap: () => onUpdate(true))
      ]));
}
