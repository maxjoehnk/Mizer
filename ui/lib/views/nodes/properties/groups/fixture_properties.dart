import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/views/nodes/properties/property_group.dart';
import 'package:select_form_field/select_form_field.dart';

class FixtureProperties extends StatelessWidget {
  final FixtureNodeConfig config;

  FixtureProperties(this.config);

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(
      title: "Fixture",
      children: [_FixtureSelector(config)],
    );
  }
}

class _FixtureSelector extends StatelessWidget {
  final FixtureNodeConfig config;

  _FixtureSelector(this.config);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixturesBloc, Fixtures>(
        builder: (context, fixtures) => SelectFormField(
              decoration: InputDecoration(labelText: "Fixture"),
              initialValue: config.fixtureId.toString(),
              items: fixtures.fixtures.map((f) {
                return {
                  'value': f.id.toString(),
                  'label': '${f.id} - ${f.name}',
                };
              }).toList(),
            ));
  }
}
