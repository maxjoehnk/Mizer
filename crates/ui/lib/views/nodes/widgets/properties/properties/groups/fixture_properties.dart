import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/widgets/controls/select.dart';

import '../fields/enum_field.dart';
import '../property_group.dart';

class FixtureProperties extends StatefulWidget {
  final FixtureNodeConfig config;
  final Function(FixtureNodeConfig) onUpdate;

  FixtureProperties(this.config, {required this.onUpdate});

  @override
  _FixturePropertiesState createState() => _FixturePropertiesState(config);
}

class _FixturePropertiesState extends State<FixtureProperties> {
  FixtureNodeConfig state;

  _FixturePropertiesState(this.state);

  @override
  void didUpdateWidget(FixtureProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(
      title: "Fixture",
      children: [_FixtureSelector(widget.config, _updateFixture)],
    );
  }

  _updateFixture(int id) {
    log("_updateFixture $id", name: "FixtureProperties");
    setState(() {
      state.fixtureId = id;
      widget.onUpdate(state);
    });
  }
}

class _FixtureSelector extends StatelessWidget {
  final FixtureNodeConfig config;
  final Function(int) onUpdate;

  _FixtureSelector(this.config, this.onUpdate);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixturesBloc, Fixtures>(
        builder: (context, fixtures) => EnumField(
              label: "Fixture",
              initialValue: config.fixtureId,
              onUpdate: onUpdate,
              items: fixtures.fixtures
                  .map((f) => SelectOption(value: f.id, label: '${f.id} - ${f.name}'))
                  .toList(),
            ));
  }
}
