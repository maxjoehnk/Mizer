import 'package:flutter/material.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/popup/popup_dmx_address_input.dart';
import 'package:mizer/widgets/popup/popup_input.dart';
import 'package:mizer/widgets/popup/popup_select.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:protobuf/protobuf.dart';

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

    return SingleChildScrollView(
      child: MizerTable(columnWidths: {
        0: FixedColumnWidth(64),
        2: FixedColumnWidth(128),
        6: FixedColumnWidth(96),
        7: FixedColumnWidth(96),
        8: FixedColumnWidth(160),
        9: FixedColumnWidth(64),
        10: FixedColumnWidth(64),
        11: FixedColumnWidth(64),
        // 11: FixedColumnWidth(64),
        // 12: FixedColumnWidth(64),
        // 13: FixedColumnWidth(64),
      }, columns: const [
        Text("Id"),
        Text("Name"),
        Text("Address"),
        Text("Manufacturer"),
        Text("Model"),
        Text("Mode"),
        Text("Invert Pan"),
        Text("Invert Tilt"),
        Text("Reverse Pixel Order"),
        Text("X"),
        Text("Y"),
        Text("Z"),
        // Text("X Rot"),
        // Text("Y Rot"),
        // Text("Z Rot"),
      ], rows: rows),
    );
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
        nameField(context, fixture, (name) => onUpdateFixture(fixture.id, UpdateFixtureRequest(name: name))),
        addressField(context, fixture, (address) => onUpdateFixture(fixture.id, UpdateFixtureRequest(address: address))),
        Text(fixture.manufacturer),
        Text(fixture.model),
        Text(fixture.mode),
        invertedAxisField(context, "Invert Pan", fixture.config.invertPan, (invertPan) => onUpdateFixture(fixture.id, UpdateFixtureRequest(invertPan: invertPan))),
        invertedAxisField(context, "Invert Tilt", fixture.config.invertTilt, (invertTilt) => onUpdateFixture(fixture.id, UpdateFixtureRequest(invertTilt: invertTilt))),
        reversePixelField(context, "Reverse Pixel Order", fixture.config.reversePixelOrder, (reversePixelOrder) => onUpdateFixture(fixture.id, UpdateFixtureRequest(reversePixelOrder: reversePixelOrder))),
        placementField(context, "X", fixture.placement.x, (x) {
          var fixturePlacement = fixture.placement.deepCopy();
          fixturePlacement.x = x;
          return onUpdateFixture(fixture.id, UpdateFixtureRequest(placement: fixturePlacement));
        }),
        placementField(context, "Y", fixture.placement.y, (y) {
          var fixturePlacement = fixture.placement.deepCopy();
          fixturePlacement.y = y;
          return onUpdateFixture(fixture.id, UpdateFixtureRequest(placement: fixturePlacement));
        }),
        placementField(context, "Z", fixture.placement.z, (z) {
          var fixturePlacement = fixture.placement.deepCopy();
          fixturePlacement.z = z;
          return onUpdateFixture(fixture.id, UpdateFixtureRequest(placement: fixturePlacement));
        }),
      ],
      onTap: () => onSelect(fixture.id, !selected),
      onDoubleTap: () => onSelectSimilar(fixture),
      selected: selected,
    );
    return row;
  }
}

Widget nameField(BuildContext context, Fixture fixture, Function(String) onUpdate) {
  return PopupTableCell(child: Text(fixture.name), popup: PopupInput(
    title: "Name",
    value: fixture.name,
    onChange: onUpdate,
  ));
}

Widget addressField(BuildContext context, Fixture fixture, Function(FixtureAddress) onUpdate) {
  return PopupTableCell(child: Text("${fixture.universe}.${fixture.channel.toString().padLeft(3, "0")}"), popup: PopupDmxAddressInput(
    title: "Address",
    value: FixtureAddress(universe: fixture.universe, channel: fixture.channel),
    onChange: onUpdate,
  ));
}

Widget placementField(BuildContext context, String label, double value, Function(double) onUpdate) {
  return PopupTableCell(child: Text("$value"), popup: PopupInput(
    title: label,
    value: value.toString(),
    onChange: (value) {
      onUpdate(double.parse(value));
    },
  ));
}

Widget invertedAxisField(BuildContext context, String title, bool inverted, Function(bool) onUpdate) {
  return PopupTableCell(
      child: Text(inverted ? "Inverted" : "Normal",
          style: inverted ? null : TextStyle(color: Colors.white54)),
      popup: PopupSelect(title: title, items: [
        SelectItem(title: "Normal", onTap: () {
          onUpdate(false);
          Navigator.of(context).pop();
        }),
        SelectItem(title: "Inverted", onTap: () {
          onUpdate(true);
          Navigator.of(context).pop();
        })
      ]));
}

Widget reversePixelField(BuildContext context, String title, bool reversed, Function(bool) onUpdate) {
  return PopupTableCell(
      child: Text(reversed ? "Reversed" : "Normal",
          style: reversed ? null : TextStyle(color: Colors.white54)),
      popup: PopupSelect(title: title, items: [
        SelectItem(title: "Normal", onTap: () {
          onUpdate(false);
          Navigator.of(context).pop();
        }),
        SelectItem(title: "Reversed", onTap: () {
          onUpdate(true);
          Navigator.of(context).pop();
        })
      ]));
}
