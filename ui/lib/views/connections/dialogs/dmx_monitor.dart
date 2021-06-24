import 'package:flutter/material.dart';

class DmxMonitor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Card(
      child: Row(children: [
        UniverseSelector(),
        AddressObserver(),
        AddressHistory(),
      ])
    ));
  }
}

class UniverseSelector extends StatelessWidget {
  const UniverseSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MonitorGroup(
      title: "Universes",
      child: ListView(
        children: [
          ListTile(leading: Text("1")),
        ],
      ),
    );
  }
}

class AddressObserver extends StatelessWidget {
  const AddressObserver({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MonitorGroup(
      title: "DMX",
      child: ListView(
        children: [],
      ),
    );
  }
}

class AddressHistory extends StatelessWidget {
  const AddressHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MonitorGroup(
      title: "History",
      child: ListView(
        children: [],
      ),
    );
  }
}

class MonitorGroup extends StatelessWidget {
  final String title;
  final Widget child;

  const MonitorGroup({this.title, this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        children: [
          Text(title),
          child,
        ],
      ),
    );
  }
}
